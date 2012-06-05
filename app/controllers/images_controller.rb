class ImagesController < ApplicationController
  
  def new
    
    @product = Product.new 
    @product.assets.build
    index=params[:index].to_i unless params[:index].nil?
    render partial: 'form',locals: {index:index}
  end
end
