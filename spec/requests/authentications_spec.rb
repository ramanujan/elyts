require 'spec_helper'

describe "Authentications" do
  
 let(:product) do
    Factory.create(:product)
  end
  
  let(:user) do
    user=Factory.create(:utente)
    user.confirm!
    user
  end 
  
  let(:admin) do
    user=Factory.create(:utente)
    user.confirm!
    user.admin!
    user
  end 
  
  context "When unsigned user wants to execute priviliged tasks on products " do
    
    before do
      @product = product
    end
    
    it "should be redirected to desidered resource after admin login" do
       visit(new_admin_product_path) 
       fill_in "Email", with: admin.email
       fill_in "Password", with: admin.password
       click_button "Login"      
      # save_and_open_page
       page.should have_selector("title",text: "ELYTS|Add new product to store")
    end
  
    it "should be denied after normal login" do
      visit(new_admin_product_path) 
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Login"      
      page.should have_content("You aren't authorized to perform this action") 
    end
  
  end
  
end
