class CartsController < ApplicationController
  
  def show
  
    @title= t("carts.show.title")
    @cart = current_cart
    @line_items = @cart.line_items.includes( product: [:assets] ) # Evito così N+1 Selects
    
  end

  

end
