class StoreController < ApplicationController
  
  before_filter :find_product, only:[:show]
 
   
  def find_product
     begin
       @product = Product.find(params[:id])
     rescue
       @title= t("products.unavailable") 
       create_product_flash_message('find_error','block')  
       redirect_to store_path
    end
  end
   
  def index
    @title=t("store.index.title") 
    @products = Product.includes(:assets).all # Evita N+1 count(*)
  
  end

  def async_index
    index
    render partial: 'products', content_type: 'text/html'
  
  end

  def show
     @title=t("store.show.title",title:@product.title)
        
  end
  
  def search
    
    # @title=t("store.search")  
    @products = Product.search(params[:search_product])
    ( params[:template] == 'search' ) ? (render partial: 'store/products') : ( render( 'store/index') )  
    
  end

  private :find_product

end
