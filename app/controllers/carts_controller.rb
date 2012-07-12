class CartsController < ApplicationController
  
  def show
  
    @title= t("carts.show.title")
    @cart = current_cart
    @line_items = @cart.line_items.includes( product: [:assets] ) # Evito così N+1 Selects
    @line_items_total_quantity = @cart.line_items.sum('quantity')
  end

  

end
