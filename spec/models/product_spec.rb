require 'spec_helper'

describe Product do
  
  before :each do
    @product = Product.new(title:"a valid title",
                           description:"A valid description",
                           price:1.50, inventory:100)   
  end
 
 context " with a blank " do
   
   it "title, should not be valid " do
     @product.title="" 
     @product.should_not be_valid
     @product.title=nil
     @product.should_not be_valid
     @product.title="     " 
     @product.should_not be_valid
   end  
   
    it "description, should not be valid " do
     @product.description="" 
     @product.should_not be_valid
     @product.description=nil
     @product.should_not be_valid
     @product.description="     " 
     @product.should_not be_valid
   end  
   
    it "selling price, should not be valid " do
     @product.price="" 
     @product.should_not be_valid
     @product.price=nil
     @product.should_not be_valid
     @product.price="     " 
     @product.should_not be_valid
    end  
   
   it "inventory, should not be valid " do
     @product.inventory="" 
     @product.should_not be_valid
     @product.inventory=nil
     @product.should_not be_valid
     @product.inventory="     " 
     @product.should_not be_valid
   end  
   
 end

 context "with a" do 
 
   it "price that isn't a valid number, should not be valid" do
     @product.price="NaN"
     @product.should_not be_valid
     @product.price=0
     @product.should_not be_valid
   end 
 
   it "inventory that isn't a valid number, should not be valid" do
     @product.inventory="NaN"
     @product.should_not be_valid
     @product.inventory=-1
     @product.should_not be_valid
   end 
 
 
 
 end

end
