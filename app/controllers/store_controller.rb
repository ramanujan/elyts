class StoreController < ApplicationController

  def index
    # @title=t("store.index") 
    @products = Product.includes(:assets).all # Evita N+1 count(*)
  
  end

  def async_index
    index
    render partial: 'products', content_type: 'text/html'
  
  end

  def show
        
  end
  
  def search
    
    # @title=t("store.search")  
    @products = Product.search(params[:search_product])
    ( params[:template] == 'search' ) ? (render partial: 'store/products') : ( render( 'store/index') )  
    
  end

end
