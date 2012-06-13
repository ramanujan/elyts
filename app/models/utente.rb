# == Schema Information
#
# Table name: utenti
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#


# == OSSERVAZIONE SULLA EMAIL 
#
# Nella nostra applicazione le email sono registrate come case-insensitive. Cioè 
# user@example.com è lo stesso di UsEr@ExAMpLE.COM questo non rispecchia il formato
# delle email in generale ma rimane un requisito di business. 
#
# Inoltre, poichè abbiamo inserito un indice nel campo email, e poichè non tutti i driver dei 
# database supportano case-sensitive-index, abbiamo scelto di salvare le email, tutte, come 
# downcase. A tale scopo abbiamo utilizzato un metodo callback di ActiveRecord. Si tratta 
# di un metodo, un blocco di codice in generale, che deve essere eseguito in certi punti del 
# ciclo di vita dell'oggetto del MODEL. 




class Utente < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  set_table_name(:utenti)
  attr_accessor(:password) 
  validates(:name, presence:true)
  validates(:email, presence:true, format:{with:VALID_EMAIL_REGEX},uniqueness:{case_sensitive:false})
  validates(:password, presence:true,confirmation:true,length:{minimum:8})  
  attr_accessible(:name, :email, :password, :password_confirmation)  
  before_save {|utente| utente.email.downcase! } 
  before_save :create_remember_token 
 
  def confirm!
    update_attribute(:confirmed,true)
  end
  
  
  # Infrastruttura per il meccanismo di autenticazione 
  
  def password=(unencrypted_password)
     
     @password=unencrypted_password  
     
     unless unencrypted_password.blank?
       
       if self.new_record? 
         make_salt
       end  
      
       self.password_digest = encrypt(unencrypted_password)
    
     end 
  
  end 
  
  def has_valid_password?(password)
  
    self.password_digest == encrypt(password)
  
  end
  
  
   def has_valid_token?(token_digest)
  
    encrypt(self.remember_token,:password) == token_digest
  
  end
  
  
  
  # Questo metodo mi serve per l'autenticazione vera e propria
  # rcorda che find_by_email è un ghost method. Ritorna nil se il record 
  # non esiste.  
  
  def self.authenticate(email,password)
    
    user = Utente.find_by_email(email)
    
    if user.nil? 
      return nil
    end    
    
    return user if user.has_valid_password?(password)
    
    nil
    
  end
  
  
  
  # used by confirmation durign account creation process
  
  def self.authenticate_from_token(token,token_digest)
    
  user = Utente.find_by_remember_token(token)
    logger.info("Inside authenticate_from_token ===> user == #{user}")
    if user.nil? 
      return nil
    end    
    
    return user if user.has_valid_token?(token_digest)
    
    nil
    
  end
  
  
  def create_digitally_signed_remember_token
    
      digest = encrypt(remember_token,:password)
      Rack::Utils.escape( "#{remember_token}--#{digest}" ) # <== È necessarion ? 
       
  end
  
  
  private 
  
    def encrypt(message,type=:password)
      message="#{message}-*-*-#{salt}" if type==:password
      Digest::SHA2.hexdigest(message)
    end 
   
 
    def make_salt
      self.salt = encrypt("#{password}-*-*-*_*-*-*-#{Time.now.utc}",:salt)   
    end
  
    def create_remember_token
      self.remember_token = SecureRandom::urlsafe_base64
    end   
    
    

end
  


=begin
  
  --- PUBLIC KEY ENCRYPTION ---
  
  L'algoritmo a chiave pubblica, prevede una chiave pubblica ed una chiave privata. Quella
  pubblica è, come dice la parola stessa, distribuita pubblicamente, e viene utilizzate dai vari
  clients per criptare i messaggi o comunque le informazioni che intendono mandare ad un server.
  Solo chi ha la chiave privata può decriptare questi messaggi. In questo modo possiamo garantire
  che i clients possano mandare i messaggi al server in maniera confidenziale e sicura.
  
  --- FIRMA DIGITALE ---
  
  Nella firma digitale il ruolo della chiave pubblica e di quella privata sono invertiti. Diciamo
  che esiste sempre un server, ovvero un nodo, che genera la coppia di chiavi. Tuttavia la chiave
  privata serve a criptare mentre la chiave pubblica, cioè la chiave distribuita pubblicamente serve
  a decriptare. In questo modo possiamo autenticare l'identità del mittente, e possiamo eliminare 
  il ripudio del mittente. 
  
  
  --- ALGORITMI DI HASHING ---
  
  Gli algoritmi a chiave pubblica, e la firma digitale,
  sono lenti quando dobbiamo spedire dei grossi file,in questo caso si preferisce 
  utilizzare degli algoritmi di hashing. ( MD5, SHA). Questi algoritmi calcolano
  un DIGEST del file o del messaggio, cioè un valore univoco solo per quel file (HASH VALUE), 
  e criptano solo il digest con la chiave privata. La peculiarità del DIGEST è che può essere
  ricreato in maniera deterministica con il medesimo algoritmo, ed è univoco per 
  quel file. Cioè se del file cambio anche un solo carattere, il DIGEST sarà 
  diverso. Pertanto la tecnica è di creare il DIGEST, criptarlo con chiave privata
  e spedire il digest al client che ha chiave pubblica. Poi di seguito spedire
  il file. Il ricevente prende il file, lo passa all'algoritmo di hashing 
  (SHA,MD5) ricrea il DIGEST e lo confronta con il DIGEST decriptato con chiave
  pubblica. Se sono uguali non c'è stata corruzione, altrimenti c'è stata 
  corruzione. 

  --- Infrastruttura per l'autenticazione ---
  
  In questa implementazione abbiamo deciso di creare tutta un'infrastruttura adeguata
  per l'autenticazione. L'idea è di riscrivere il metodo password=(unencrypted) in modo
  che crei una password criptata con un algoritmo di hashing e ponga questa password il
  password_digest un attributo fisico creato ad hoc. 
  
  Si noti che il fulcro è il metodo encrypt(message). Questo metodo esegue l'hashing del messaggio
  mixato con un salt univoco. A tale scopo bisogna creare la colonna salt, l'attributo fisico che andrà
  popolato solo inizialmente, quando il record è transient. Ma procediamo con ordine: 
  
  1)   def encrypt(message)
         Digest::SHA2.hexdigest("#{message}-*-*-#{salt}") 
        end 
  
  Questo metodo si occupa di creare il digest della stringa qui sopra e quindi di criptarlo con una
  chiave privata. 
  
    
=end

