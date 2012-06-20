# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  $('#login').click((event)->
    event.preventDefault()
    li = $(this).parent()
    form = li.find('form')
    unless li.hasClass('on')
      li.addClass('on')
      form.slideDown()
    else
      form.slideUp(500,->
        li.removeClass('on')
        )
    
   )
)