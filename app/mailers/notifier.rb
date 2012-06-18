=begin
 
  Come vediamo un componente mailer, è un componente che sembra proprio un controllore.
  Un metodo per template di email, e quindi invece di invocare render per mostrare il layer
  della presentazione, viene invocato il metodo mail.
  
  Il metodo mail() accetta parametri come :to,:cc, :from, and :subject, 
  ognuno dei quali ha la semantica che ti aspetti. I valori che sono comuni a tutti i tipi di
  email, possono essere impostati come defaults semplicemente invocando il metodo default()
  
  In questo caso abbiamo utilizzato: 
  
  default from: "..."
  
    

  
=end

require 'socket' # Mi serve per recuperare l'ip address della macchina

class Notifier < ActionMailer::Base
  default from: "Elyts <pater.patronis@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.new_user_creation.subject
  # ED IO l'HO FATTO !! :-) 
  
  def new_user_creation(user)
    @user = user
    hostname=nil
    Rails.env=='production' ? hostname=Constant::HEROKU_HOST : hostname=Constant::WORLDWIDE_HOST
    @url= "http://#{hostname}/utenti/#{user.create_digitally_signed_remember_token}/confirm"
    mail(to:user.email, subject: "Elyts account confirmation") 
    
  end
  
  private
    
   # The above code does NOT make a connection or send any packets (to 64.233.187.99 which is google). 
   # Since UDP is a stateless protocol connect() merely makes a system call which figures out how 
   # to route the packets based on the address and what interface (and therefore IP address) 
   # it should bind to. 
   # addr() returns an array containing the family (AF_INET), local port, and local address 
   # (which is what we want) of the socket.

    
    def local_ip
      # turn off reverse DNS resolution temporarily
      orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  
     
      UDPSocket.open do |s|
        s.connect '64.233.187.99', 1
        s.addr.last
      end
    ensure
      Socket.do_not_reverse_lookup = orig # restore reverse DNS lookup   
    end
    
    
end
