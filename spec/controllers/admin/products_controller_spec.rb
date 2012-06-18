require 'spec_helper'

=begin
  
  In questa applicazione ho utilizzato RSpec per testare oggetti del MODEL a seconda delle 
  validazioni costruite. Adesso in questa sede, eseguo dei test per testare il comportamento
  dell'applicazione quando un utente cerca un URL che non esiste o malformato. Perchè utilizzare
  RSpec piuttosto che Cucumber ? perchè richiedere risorse che non esistono o URL malformati, è
  qualcosa che un utente può fare, ma che NON DOVREBBE FARE. Invece con cucumber testiamo scenari
  che non sono eccezionali (cioè prevediamo solo quello che l'utente può fare ) e non quello che 
  non dovrebbe fare. 
  
  OSSERVAZIONE: Un blocco context andrebbe utilizzato per specificare un contesto di un esempio piuttosto
                che descrivere cosa fa l'esempio
    
=end

describe Admin::ProductsController do

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
  
  
  context " When standard (signed in but not admin) users want to do something with a product " do
     
    
    it "cannot access the new action" do
      login(user) # => vedi support/login.rb 
      get :new 
      response.should redirect_to root_path
      flash[:block].should eql("You aren't authorized to perform this action")  
    end
    
    it "cannot perform anything" do
       login(user) # => vedi support/login.rb 
      {new: "get", create: "post", edit: "get", update: "put", destroy: "delete" }.each do |action,method|
        send(method.to_sym,action,id: product.id)
        response.should redirect_to root_path 
        flash[:block].should eql("You aren't authorized to perform this action")  
      end
    
    end
  
  end
  
  
  context " When a product doesn't exists" do
    before do
      login(admin)
    end
    
    it "should redirect to products index" do
      get :show, id:"not-here"
      response.should redirect_to(admin_products_path)
      message="The product you are looking for could be not found"
      flash[:block].should eql(message)     
    end
    
     it "should redirect to products index" do
      get :edit, id:"not-here"
      response.should redirect_to(admin_products_path)
      message="The product you are looking for could be not found"
      flash[:block].should eql(message)     
    end
  
    it "should redirect to products index" do
      get :update, id:"not-here", product: product
      response.should redirect_to(admin_products_path)
      message="The product you are looking for could be not found"
      flash[:block].should eql(message)     
    end   
  
  
  end
  
  describe 'when updating inventory with ajax control' do
    before do
      login(admin)
    end
    
    it "should change inventory column" do
        expect {
          put :inventory, :inventory=>100, :id=>product.id
        }.to change{Product.find(product.id).inventory}.to(100)                   
      end
  
  end
  
  
end
