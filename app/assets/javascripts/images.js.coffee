ImagesController={}

ImagesController.add_another_image=()->
  $("#add_another_image").click(->
    index = $("#images input").length
    url = "/images/new?index="+index
    $.get(url,
      (data)-> $("#images").append(data)
      "html")
  )  
  
$( ()-> ImagesController.add_another_image() )