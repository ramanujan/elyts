class StaticPagesController < ApplicationController

  def home

  end
 
  def heroku_db_reset
    @output = `rake db:reset`
    @title="Heroku db reset" 
    @ls = `ls -la`
  end

  def heroku_db_migrate
    @output = `rake db:migrate`
    @title="Heroku db migrate" 
  end
  
  def heroku_ls
     @ls_assets = `cd app/assets/ && ls -la`
     @ls_images = `cd app/assets/images && ls -la`
     @ls_compiled_assets = `cd public/assets/ && ls -la`
  end
  
  def heroku_rake_routes
    @rake_routes = `rake routes`
  end
  
  
  #-------------------------------------------------------------
  
  def jquery_sliding_effects
    
  end
 

=begin
 
 --- JQuery Sliding effects ---
 
  Quando un elemento è nascosto con display:none, possiamo mostrarlo con l'animazione
  jquery nota come slidingDown(): 
 
    jQuery(elements).slideDown([duration], [easing] [callback]);

  [duration]
  
    Il primo parametro può essere un intero oppure una stringa.La durata è espressa in millisecondi.
      "fast" = 200
      "slow" = 600 
    per default la durata è di 400 millisecondi.
  
  [easing]
    
    Questo argomento, ci permette di specificare una funzione, un metodo, che specifica la volecità
    di progresso dell'animazione in punti differenti dell'animazione. Per default in distribuzione
    standard jquery fornisce 2 implementazioni che sono: 
    
      swing
      linear
    
    altre sono disponibili con jquery ui suite. 
  
  
  [callback]
  
    Questo è un metodo, una funzione di callback che possiamo invocare dopo che l'animazione
    è finita. Ad esempio questa animazione porta il display type da none a block, e per alcuni
    elementi il display type naturale è inline-block. Con una callback a fine animazione possiamo
    cambiare il display type. 
        
  Oltre che la proprietà display:, questa animazione va a impostare anche la proprietà height: in modo
  da scoprire gradualmente l'elemento da mostrare, quindi proprietà che influenzano height: come 
  padding:  e margin: possono influenzare l'animazione. 
  
  Lo sliding  di un elemento che ha padding: e margin: impostati possono far apparire l'animazione
  inusuale con gli elementi all'interno che appaiono muoversi a loro volta. 
  
  Padding or margin possono rendere l'animazione increspata e irregolare.
  Elementi che NON hanno width: fisso possono causare problemi quando animati con slideDown(),
  slideUp() oppure slideToggle(). or slideToggle().
 
  Se margin: e/o padding sono richiesti, oppure se fixed-width non è possibile, è allora consigliabile 
  utilizzare un elemento WRAPPER, attorno all'elemento da animare.  
  wrapper element oppure di lasciare il padding e margin richiesti. Tutti i metodi sliding ritornano
  l'originale JQuery Obect e quindi possono essere utilizzati in chaining. 
  In aggiunta gli effetti sliding, sono salvati nella coda FX dell'elemento selezionato (vedi altrove)
  quando diversi effetti sono incatenati ad un singolo elemento. 

 
  
=end

  
  def css_positioning
    
  end
  
    
end
