class StoreController < ApplicationController
  
  before_filter :find_product, only:[:show]
  before_filter :retrieve_cart
  before_filter :calculate_number_of_elements_in_cart, only:[:index,:show]
    
  def find_product
     begin
       @product = Product.find(params[:id])
     rescue
       @title= t("products.unavailable") 
       create_product_flash_message('find_error','block')  
       redirect_to store_path
    end
  
  end
  
  def retrieve_cart
  
    @cart = current_cart
  
  end
  
  # Calcola effettivamente il numero totale di elementi e non quello di prodotti
  
  def calculate_number_of_elements_in_cart
    
     @line_items_count = @cart.line_items.sum('quantity')
     
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

  private :find_product, :retrieve_cart, :calculate_number_of_elements_in_cart
  

end
