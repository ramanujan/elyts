require 'spec_helper'

=begin
  
  In questa applicazione ho utilizzato RSpec per testare oggetti del MODEL a seconda delle 
  validazioni costruite. Adesso in questa sede, eseguo dei test per testare il comportamento
  dell'applicazione quando un utente cerca un URL che non esiste o malformato. Perchè utilizzare
  RSpec piuttosto che Cucumber ? perchè richiedere risorse che non esistono o URL malformati, è
  qualcosa che un utente può fare, ma che NON DOVREBBE FARE. Invece con cucumber testiamo scenari
  che non sono eccezionali (cioè prevediamo solo quello che l'utente può fare ) e non quello che 
  non dovrebbe fare. 
  
    
=end

describe Admin::ProductsController do

 let(:product) do
    Factory.create(:product)
  end
  
  context " When a product doesn't exists" do
    
    it "should redirect to products index" do
      get :show, id:"not-here"
      response.should redirect_to(admin_products_path)
      message="The product you are looking for could be not found"
      flash[:block].should eql(message)     
    end
  
  end
  
  describe 'when updating inventory with ajax control' do
      
      it "should change inventory column" do
        expect {
          put :inventory, :inventory=>100, :id=>product.id
        }.to change{Product.find(product.id).inventory}.to(100)                   
      end
  
  end
  
  
  
end
