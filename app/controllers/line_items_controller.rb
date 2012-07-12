class LineItemsController < ApplicationController
  
  include(::Admin::ProductsHelper)  # N.B. DEVI INCLUDERE IL MODULO MANUALMENTE
  
  before_filter :find_product
  before_filter :retrieve_cart
  before_filter :create_or_update_product
   
  # Ricordiamo che il metodo build() aggiorna l'associazione tra LineItem e Cart in modo che 
  # il record relativo all'istanza di LineItem che stiamo creando, abbia la colonna cart_id con il valore 
  # dell'id dell'istanza di Cart ritornata da current_cart().

  # Il metodo build() però non propaga il record aggiunto con build(). Bisogna eseguire un save() 
  # esplicitio su current_cart

  
  def create
    
    respond_to do |format|
      
      
      
      format.html{
        
        if @cart.save # Perchè avvenga l'aggiornamento dovuto a update_quantity bisogna mettere 
                      # un'associazione di tipo :autosave tra Cart e LineItem, oppure esegui 
                      # un update esplicito, come fatto qui, in update_attribute() 
                      
          redirect_to( cart_path( @cart ) )  
        else
          flash[:block]=t("line_items.create.failure")
          redirect_to store_path(@product.id)
        end
     } 
     
     
     
     format.json{
       logger.info("**********************************************************")
       
       @cart.save ? ( render json: { number_of_items:@cart.line_items.sum('quantity') } ) : 
                    ( render json: { error: t("line_items.error") } )
       
     }
     
    
    end
  
  end
   
  
  
  private
    
    def find_product
     
      begin
        @product = Product.find(params[:product_id])
      rescue
        @title= t("products.unavailable") 
        create_product_flash_message('find_error','block')  
        redirect_to(store_index_path)
      end 
    
    end

    
    def retrieve_cart
     
      @cart = current_cart # Recupero o creo il carrello 
    
    end
    
    
    def is_present?(product)
      
      @cart.line_items.where('product_id=:id',id:product.id).first
       
       # @cart.line_items.include?(product)
    
    end

    
    def update_quantity(line_item,num)
     
      
      line_item.quantity+=num;
      line_item.save
      
    end


    def create_or_update_product
       # Se il prodotto è presente in line_items, aggiorno quantity column, altrimenti creo nuovo line_item 
   
      if is_present?( @product ) 
        
        @line_item = @cart.line_items.where('product_id=:product_id',product_id:@product.id).first
        update_quantity( @line_item,1 ) 
      
      else
      
        @cart.line_items.build(product:@product)
        @line_item = @cart.line_items.last   # <=== ATTENZIONE, VALUTARE SE FUNZIONA SEMPRE ! 
      
      end
     
    end


 end