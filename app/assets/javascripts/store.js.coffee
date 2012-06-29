# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

search = ->
  $('form#search_product input').keypress((event)->
    if event.which == 13  
      $(this).blur();
      event.preventDefault()
      
      if  $('#store_products').length > 0
        value = "search"
      else
        value = "index"  
      action = $('form#search_product').attr('action')
      
      $( "<input name='template' type='hidden' value='"+value+"'/>").appendTo('form#search_product') 
      
      if value == 'search'     
        $.ajax({
          type: 'GET',
          url:action,
          data: $("form#search_product").serialize(),
          dataType: 'html', # <=== Lo puoi fare solo se imposti content_type dal metodo render:
          success: (data)-> 
            $('#store_products').html(data)
           
            $('#number_of_products_found').text("("+window.products+")")
        });
      
      else $("form#search_product").submit()
    )  


allProductsHandler = ()->
  $('#all_products').click((e)->
    if  $('#store_products').length > 0
      value = "ajax"
    else
      value = "normal"  
     
    if (value == "ajax")
      e.preventDefault()
     
      
      $.ajax({
        type: 'GET',
        url: '/store/async_index'
        dataType: 'html', # <=== Lo puoi fare solo se imposti content_type dal metodo render:
        success: (data)->
          $('#store_products').html(data)
          $('#number_of_products_found').text("("+window.products+")")
        });

   
  )

$(->
  search();
  allProductsHandler();
)
