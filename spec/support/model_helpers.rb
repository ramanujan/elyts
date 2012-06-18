module ModelHelpers 
 
 def let_user
 
   let(:user) do
      user=Factory.create(:utente)
      user.confirm!
      user
    end 
 
 end
  
 def let_product
    let(:product) do
      Factory.create(:product)
     end
 end
 
 def let_admin
    
    let(:admin) do
      user=Factory.create(:utente)
      user.confirm!
      user.admin!
      user
    end 
 
 end
    
end

RSpec.configure do |config|
  
  config.include(ModelHelpers)
  
end