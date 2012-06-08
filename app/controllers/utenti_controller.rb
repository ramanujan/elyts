class UtentiController < ApplicationController
  
  def new 
    @title=t("utenti.new.title")     
    # ==> NON MI SERVE PERCHÈ NON POSSO AFFIDARMI ALL'INFLECTOR E UTILIZZARE form_for() 
    # però mi serve per shared/errors
    @utente = Utente.new  
  end
  
  def create
    @utente = Utente.new params[:utenti]
    if @utente.save 
      
      flash[:block] = t("utenti.create.created")
      render "confirm_registration"    
    else
      render 'new'
    end     
  
  end


end
