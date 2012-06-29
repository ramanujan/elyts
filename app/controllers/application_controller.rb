class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private 
    
    def current_cart
      begin
        cart = Cart.find( session[:cart_id] )  
      rescue
        cart = Cart.create
        session[:cart_id] = cart.id 
      end
      cart
    end

end
