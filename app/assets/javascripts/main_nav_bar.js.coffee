handlerInLink = ()->
  $(this).addClass('on').next().slideDown('fast',"linear")
   
handlerOutList = ()->
  $(this).prev().removeClass('on').next().slideUp('fast')
  $.data(this,'on_list',false)

handlerOnList = ()->
  $.data(this,'on_list',true)

handlerOutLink = ()->
  # L'idea di questo timeout è di controllore se dopo tot millsec sono dentro list oppure no
  timeout=setTimeout(()->
   
    unless $('.slide_down ul').data('on_list')
      $('.slide_down a').removeClass('on').next().slideUp('fast') 
      clearTimeout(timeout)  
  ,300
  )  


$(-> 
  $('.slide_down a').mouseenter(handlerInLink)
  $('.slide_down ul').mouseleave(handlerOutList)
  $('.slide_down ul').mouseenter(handlerOnList)
  $('.slide_down a').mouseleave(handlerOutLink)
  )