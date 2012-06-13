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

class Notifier < ActionMailer::Base
  default from: "Elyts <pater.patronis@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.new_user_creation.subject
  # ED IO l'HO FATTO !! :-) 
  
  def new_user_creation(user)
    @user = user
    @url= "http://stark-sunrise-9483.herokuapp.com/utenti/#{user.create_digitally_signed_remember_token}/confirm"
   #require 'socket'
   #hostname = Socket.gethostname
   #@url= "http://#{hostname}/utenti/#{user.create_digitally_signed_remember_token}/confirm"
  
    mail to:user.email, subject: 'Elyts, complete the registration process'   
  end


end
