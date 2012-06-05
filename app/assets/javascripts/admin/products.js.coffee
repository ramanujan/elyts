###

Tanto per cominciare si noti che il pattern  

  $(document).ready(function(){
  
    ...
  })  

è talmente utilizzato che JQuery mette a disposizione una bella shortcut: 

$() al posto di $(document).ready(). Seguendo una convenzione di questo tipo, 
allora possiamo scrivere semplicemente 

$(function(){
  
}) 
_______________________________________________________________________________________


In CoffeeScript abbiamo che :

function(x){ 
  # do something
}
  
Equivale a: 
(x)->
  #do something  
   
Ovviamente occhio all'indentazione è importante, perchè grazie ad essa l'interprete coffeeScript può 
riconoscere dove comincia una funzione e dove finisce. 
 
____________________________________________________________________________________________________

--- UNOBTRUSIVE JAVASCRIPT ---
 
In HTML5 possiamo utilizzare CUSTOM DATA ATTRIBUTES per memorizzare i dati correlati ad un elemento
nella pagina. Ad esempio per memorizzare un messaggio che deve essere visualizzato quando verrà 
cliccato un ben determinato link, possiamo riscrivere il link in questo modo: 
    
    <a href="#" id="alert" data-message=" Hello from UJS " >Click Here</a>
  
  E quindi in javascript possiamo facilmente eseguire: 
  
    $(function () {
      $('#alert').click(function () {
        alert(this.attr('data-message'));
        return false; // ===>  ovvero prevent default  
      })
    });
    

--- RAILS 3 UTILIZZA UNOBTRUSIVE JAVASCRIPT---
   
Rails 3 utilizza HTML5 CUSTOM DATA ATTRIBUTES nel suo approccio al concetto di unobtrusive javascript
come modo di PASSARE I DATI GENERATI LATO SERVER AL CLIENT CODE JAVASCRIPT. Si pensi a questa 
applicazione e-commerce. Essa ha una lista di prodotti, su cui possiamo effettuare delle ricerche. 
Ci sono anche dei link per editare ed eventualmente per distruggere dei prodotti in vendita. 
Vediamo ad esempio un semplice link che esegue la distruzione di un prodotto: 
   
   <a href="/admin/products/1" 
      class="btn btn-danger" 
      data-confirm="Are you sure you want to delete Domenico Cyborg D'Egidio  ?" 
      data-method="delete" 
      rel="nofollow">
      
      <i class="icon-trash icon-white"></i>
      Delete Product
   /a>   
  
  Come si vede fa un uso massiccio di HTML-CUSTOM-DATA-ATTRIBUTE! Infatti quando andiamo a cliccare 
  sul link, viene eseguito tramite XHR immagino, una POST com passando un parametro _method=delete
  e prima viene aperta una alert con i dati salvati in data-confirm

 _____OSSERVAZIONI SU INVENTORY________
   
 Aggiorno inventory. Si noti che quando viene premuto il bottone 'update inventory'
 viene eseguita ProductsController#inventory.
 @temp=@product.inventory # Mi serve per aggiornare il campo inventory dopo l'azione ajax 
 render :partial=>'shared/flash_messages',:content_type=>'text/html'
           
 Come si vede abbiamo modificato flash_message per gestire una variabile temporale
 che verrà passata al codice javascript tramite <%javascript_tag do .. end %>
 in questo modo possiamo passare via temporaryVariable il nuovo valore del campo 
 inventory appena modificato.   


###



AdminNavbarController = {} # In CoffeScript crea un oggetto javascript 

AdminNavbarController.start=()->
  location = window.location.pathname      
  pattern = 'li:has(a[href="'+location+'"])'
  $(pattern).addClass("active")
 
 
# -----------------------------------------------------------------------------------------------------
 
 InventoryController = {}
 
 InventoryController.start=()->

   form = null
     
   $(".inventory_update_button").click((event)->
     event.preventDefault()
     form           = $(this).parent()
     inventoryValue = form.find('input#inventory').val()
     action         = form.attr('action') 
     row            = $(this).parents('div.product')   
     
     $.ajax({
       type: 'PUT',
       url:action,
       data: form.serialize(),
       #dataType: 'html', # <=== Lo puoi fare solo se imposti content_type dal metodo render:
       success: (data)-> 
         notificationZone = row.find(' > div.ajax_notification ')
         if notificationZone.length > 0 
           $(notificationZone).fadeToggle().fadeToggle().html(data)
         else  
           $("<div class= 'row-fluid ajax_notification'></div>").
             html(data).prependTo(row).fadeToggle()
      

         form.find('input#inventory').attr('placeholder',temporaryVariable) if temporaryVariable
     
     });  
    
     )
   
#----------------------------------------------------------------------------------------------------   


$(()->
    AdminNavbarController.start()
    InventoryController.start()
)
  