class Ham
  
  def edible?
    !@expired  
  end 
  
  def expired!
    @expired=true
  end 
  
  def expired?
   @expired
  end

end