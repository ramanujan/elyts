class Admin::BaseController < ApplicationController
  
  include SessionsHelper
  before_filter :authorize_admin! # I filtri vengono ereditati. 
  
  def index
    @title=t("admin.base.index.title")
  end 

# authorize_admin! mi serve per vedere se l'utente che sta eseguendo una determinata azione è 
# a tutti gli effetti un amministratore. Ho messo un metodo bang! perchè fa divergere il normale 
# flusso degli eventi accesi (ad esempio per la richiesta di creazione di un nuovo prodotto) caso
# mai l'utente non sia un amministratore.

  private
    
    def authorize_admin!
      unless logged_in?
         store_location # <== Mi serve per ricordare il link richiesto, ma di cui ci serve autenticazione
         redirect_to(new_session_path) 
         return
      end    
    
      unless current_user.admin?
        flash[:block]=t("admin.base.authorize_admin.error")
        redirect_to(root_path)
      end
  
    end

end