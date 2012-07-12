require 'spec_helper'



describe LineItemsController do
  
  
  
  let(:product) do
    FactoryGirl.create(:product)
  end
 
  
  context " when adding a product to cart with ajax control ", :type => :with_rack_methods do
    
    it "should add a new line item" do
     
      expect {
        post "/line_items.json", product_id:product.id
      }.to change{LineItem.count}.by(1)  
    end  

  end

 


end
