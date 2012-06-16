
=begin
   
   Si noti che il comando 'rails g controller admin/products' genera questo controllore nel modulo
   Admin. Qui un modulo è utilizzato come namespace per separare un controller (ProductsController) 
   utilizzato solo dagli utenti amministratori, da un controller (ProductsController) utilizzato dagli utenti 
   normali o buyer. Poichè vogliamo ereditare delle caratteristiche tipiche per il controller dentro il pacchetto
   Admin, allora ereditiamo da una stessa classe di base che chiameremo BaseController
    
=end
class Admin::ProductsController < Admin::BaseController
 
  include(::Admin::ProductsHelper)  # N.B. DEVI INCLUDERE IL MODULO MANUALMENTE
  
  before_filter :authorize_admin! # metodo private in BaseController 
  before_filter :find_product, only:[:show,:inventory,:edit,:update]
   
  
  def find_product
     begin
      @product = Product.find(params[:id])
     rescue
      @title= t("products.unavailable") 
      create_product_flash_message('find_error','block')  
      redirect_to admin_products_path
    end
  end
  
  private :find_product
  
  
=begin
  AR ha la capacità di eliminare il problema delle N+1 Selects. In questo caso abbiamo utilizzato
  N+1 selects per evitare di sprecare N+1 select count() dovute a product.any? dentro la view 
  
  
=end  
  
  def index
    
    @title=t("admin.products.index.title")
    @products = Product.order('title asc').includes(:assets).all
    
  end

  def show
    @title=t("admin.products.show.title",title:@product.title) 
  end


  def new
    @title=t("admin.products.new.title")
    @product = Product.new 
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      create_product_flash_message('create_success','block') # Vedi products_helpers
      redirect_to [:admin,@product]     
    else
      render :new # Nessun flash message. I messaggi d'errore sono auto-esplicativi
    end
    
  end
  


  def edit
     @title=t("admin.products.edit.title",title:@product.title)
  end
  


  def update
    begin
      
      if @product.update_attributes(params[:product])
          create_product_flash_message('update_success','block') 
          redirect_to [:admin,@product]
      else
        render :edit
      end  
    
    rescue => msg
      flash[:error]=t("admin.products.update.error",msg:msg)
      redirect_to  [:admin,@product]
    end
  end
  
  
  
=begin
  
  Product#delete utilizza SQL delete diretto. Non carica alcuna istanza prima della 
  distruzione del record e quindi è rapido. Però attenzione, in questo modo non verranno
  accesi callbacks come before_delete() e anche non verranno rispettate le associazioni 
  parent-child. 
  
  A me comunque servono i dati del record cancellato per eseguire la notifica della cancellazione.
  In particolare il title del product. Pertanto utilizzo destroy() che carica prima l'istanza
  e poi cancella dal database il record relativo.
      
=end  
  
  def destroy
  
    @product = Product.destroy(params[:id])
    create_product_flash_message('delete_success','block') # Vedi products_helpers 
    redirect_to(admin_products_path) 
  
  end
   

=begin
   
   In questo metodo si è scelto di utilizzare ActiveRecord::Persistence#update_attributes()
   e non  ActiveRecord::Persistence#update_attribute() <=== poichè quest'ultimo :
   
   
   1) SALTA le validazioni
   2) INVOCA Callbacks
   3) AGGIORNA updated_at/updated_on 
   4) AGGIORNA tutti gli altri attributi che sono dirty nell'oggetto !
   
   Invece update_attributes() aggiorna gli attributi specificati nell'hash, e invoca save(). 
   Questo mi serve perchè desidero avero la possibilità di validare il campo quantity, e 
   precisamente desidero che sia comunque un numero. 
   
   Questo apre tutta una discussione sulla trattazione della risposta AJAX nel caso di 
   failure oppure nel casa sia andato tutto bene, e l'aggiornamento abbia avuto luogo!
   
   Si infatti voglio che questa sia un'azione AJAX.  In particolare genero sempre un flash message
   sia che l'aggiornamento abbia avuto luogo senza problemi, sia che si siano verificati problemi.
   Poi nella presentazione mando al client un frammento HTML contenente la presentazione dei
   messaggi,che però verranno visualizzati in un'altro modo? oppure in maniera analoga nel solito posto?
   
=end


  def inventory
    begin
      if @product.update_attributes( :inventory=>params[:inventory] )  
       create_product_flash_message('update_inventory_success','block',:now_type) # Vedi products_helpers
       @temp=@product.inventory # Mi serve per aggiornare il campo inventory dopo l'azione ajax 
     else
       create_product_flash_message('update_inventory_invalid','block',:now_type) # Vedi products_helpers
     end    
   
   rescue => msg
     flash[:error]=t("admin.products.update.error",msg:msg)
   end
   
  
   render :partial=>'shared/flash_messages',:content_type=>'text/html'
  
  end
   

end
