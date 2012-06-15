=begin
  
  In questa applicazione abbiamo implementato un meccanismo di login basato su di un REMEMBER ME TOKEN
  e cioè un login che dura non solo finchè il browser è attivo ma fino a che l'utente non abbia 
  eseguito un esplicito logout. 
  
  Questo meccanismo è basato principalmente sull'utilizzo di cookies. In pratica utilizzeremo la gestione 
  della sessione in Rails, per mantenere un REMEMBER TOKEN. 
  
    session[:remember_token] = user.id
    
  Il componente session di Rails, lo possiamo pensare come un Hash. Il meccanismo di storage di default
  è quello di salvare questi oggetti in cookies come abbiamo già detto altrove. Di default questo cookie
  scade alla chiusura del browser. Alla scadenza non viene più spedito dal browser. Il meccanismo di
  storage è sicuro dal punto di vista della corruzione da parte di un utente con cattive intenzioni. 
  Infatti ricordiamo che verranno eseguiti i seguenti passaggi:
  
    a) sid = ActiveSupport::SecureRandom.hex(16)
           
    b) h = { :rememeber_token=>user.id, :session_id=>sid, 'flash'=>{} }
    
    c) data = ActiveSupport::Base64.encode64( Marshal.dump(h) )
       
    d) escaped_data_value = Rack::Utils.escape(data) # Questo esegue URI escape, ad esempio utile per costruire query string. 
           
    e) digest = 'SHA1'    (  diverso da : Digest::SHA2.hexdigest(message)   )
           
    f) digest_value = OpenSSL::HMAC.hexdigest( OpenSSL::Digest::Digest.new(digest), secret, data )
           
    g) final_output = "#{escaped_data_value}--#{digest_value}"
             
    
  Quando il contenuto di questo cookie viene spedito dal browser, allora Rails spezza il contenuto
  all'altezza di -- e quindi ottiene escaped_data_value e digest_value. Esegue unescape e riottiene
  la stringa codificata base64- Da questa riproduce il digest e vede se è uguale a quello pervenuto. 
  Se non è così viene lanciata un'eccezione altrimenti il contenuto del cookie è accettato. IL problema
  è che questo cookie scade alla chiusura del browser. Per creare un meccanismo per le connessioni 
  persistenti, dobbiamo utilizzare un identificatore permanente per l'utente che ha eseguito il login.
  Per fare ciò, genereremo un SICURO,UNIVOCO REMEMEBER TOKEN per ogni utente che si è autenticato.
  Questo REMEBER TOKEN lo memorizzeremo dentro un cookie CHE SCADE DOPO 20 ANNI cioè un 
  COOKIE PERMANENTE. Ovviamente per individuare esattamente un singolo utente, il REMEMBER TOKEN 
  dovrà essere associato ad un record nel database utenti, quindi sarà una colonna univoca della tabella
  utenti! 
  
  Come utilizzare il remember token? Ci sono in generale molte possibilità equivalenti. Essenzialmente
  si tratta di mettere una lunga e larga stringa random. In questa applicazione abbiamo deciso di +
  utilizzare:  
  SecureRandom#urlsafe_base64(). SecureRandom è un modulo della libreria standard di Ruby.Questo metodo
  ci serve per creare una stringa sicura codificata base64, che può essere utilizzata per URLs e quindi
  è sicura anche per essere piazzata in un cookie. (Ricorda che le stringhe il URLs e Cookies vanno 
  filtrata per i caratteri speciali del protocollo) 
  
  SecureRandom.urlsafe_base64() ritorna una stringa random di 16 caratteri A–Z, a–z, 0–9, “-”, 
  and “_" 
  
  Poichè i metodi relativi al meccanismo di login, mi servono a livello del controller e anche della
  view, allora ho deciso sicuramente di piazzare questi metodi all'interno di un modulo. Questo
  modulo si chiama SessionsHelper che viene incluso automaticamente nelle view generate per le 
  azioni del controller Sessions, e che dobbiamo includere manualmente nella classe del controller
  SessionController.   
  
  --- Il metodo login() ---
  
  Nel modulo SessionsHelper abbiamo inserito il metodo login(). In questo metodo dobbiamo eseguire 
  il login vero e proprio: 
  
   cookies.permanent[:remember_token] = user.remember_token
   self.current_user = user
 
  che equivale sostanzialmente a : 
  
    cookies[:remember_token] = { value:   user.remember_token,
                                 expires: 20.years.from_now.utc }
    self.current_user = user                          
 
  In questo modo, abbiamo implementato una sessione permanente. Infatti questo cookie scade tra venti
  anni e viene rispedito al server ogni volta che ci colleghiamo anche quando abbiamo spento il
  browser. Forse, sarebbe meglio per la nostra applicazione implementare almeno un check-box 
  remember-me forever e spedire un cookie che scade. Ma vedremo dopo con calma.  
  
  OSSERVAZIONE: Si noti che siamo slegati dal sid inviato!   
  
  --- Session hijacking----------------------------
  
  questo meccanismo è soggetto ad un attacco detto session hijacking.Infatti il remember token è un 
  normale token non firmato, una stringa codificata base64 che viene trasmessa in rete e che identifica
  un utente. Qualcuno potrebbe copiare il remember token e utilizzarlo per eseguire il login 
  e rubarci quindi l'identità. Ovviamente anche un cookie firmato non fermerebbe l'atttacco. 
  Questo attacco è stato pubblicizzato da Firesheep application che ha mostrato che molti siti ad alto
  profilo  (including Facebook and Twitter) sono vulnerabili. 
  LA SOLUZIONE È di utilizzare SSL (vedremo dopo). Ovviamente potremmo anche utilizzare 
  cookies.signed questo tuttavia non sembra risolvere il problema del man in the middle. 
  
  
=end


class SessionsController < ApplicationController
  include SessionsHelper;
  
  def new
    @title = "Login"  
  end

  def create
    
    utente=Utente.authenticate( params[:session][:email], params[:session][:password] )
    
    if utente              
      utente.confirmed? ? login(utente) : flash[:error]=t("sessions.create.confirm_required")
    redirect_to(root_path)
    else
      flash.now[:error]=t("sessions.create.auth_error")
      render(:new)
    end
  
  end
  
  
    
# Se il token che arriva dalla email è ok, allora eseguo il login e notifico la conferma dell'avvenuta 
# registrazione. 
# Se d'altra parte il token è stato corrotto, allora notifico l'error. Si noti che in questo caso
# l'utente dovrà richiedere esplicitamente all'amministratore di eliminare il record, oppure possiamo
# implementare un cron task, che elimina gli account non confermati dopo un tot tempo
  
  def confirm_account_and_login 
    unescaped = Rack::Utils.unescape( params[:token] )
    result = unescaped.split("--") 
    
    user = Utente.authenticate_from_token(*result)
  
    unless user.nil?
      begin
        user.update_attribute(:confirmed,true)
        login(user)
        flash[:block]=t("utenti.confirm_account.success")   
       
      rescue=>msg
        logger.info("EXCEPTION OCCURS DURING EXECUTION ==> #{msg}")
        flash[:error]=t("utenti.confirm_account.exception",email: Constant::ADMIN_EMAIL)
      end 
    
    else
      flash[:error]=t("utenti.confirm_account.error",email: Constant::ADMIN_EMAIL)
      
    end
    
    redirect_to(root_path)    
  
  end
 
  
   
  def destroy
    logout
    redirect_to(root_path)
  end 

end
