class Admin::UsersController < Admin::BaseController
  
  def index 
    @title=t("admin.users.index.title")
    @users = Utente.order('name asc').all
  end
  
  
  def show
    
  end
  
  def new
    @title=t("admin.users.new.title")
    @utente = Utente.new 
  end

  def create
    admin = params[:utenti].delete(:admin)   
    @utente = Utente.new params[:utenti]
    @utente.admin=(admin=="yes") 
    @utente.confirmed=true 
    if @utente.save 
      
      @utente.is_admin? ? flash[:block] = t("admin.users.created",email: @utente.email) : 
                          flash[:block] = t("utenti.create.created",email:@utente.email)
      redirect_to(admin_users_path)    
    
    else
      render 'new'
    end     
  end

end
