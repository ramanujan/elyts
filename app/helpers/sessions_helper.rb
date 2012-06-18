module SessionsHelper

  def login(user)
   cookies.permanent[:remember_token]= user.remember_token 
   self.current_user = user
  end

  def current_user=(user)
    @user = user
  end 
  
  def current_user
    @current_user ||= Utente.find_by_remember_token(cookies[:remember_token])
  end
  
  def logged_in?
    !current_user.nil?
  end 
  
  def store_location
     session[:return_to] = request.fullpath
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end  
  
  def logout
    current_user=nil
    cookies.delete(:remember_token)
    reset_session
  end
  
  
end
