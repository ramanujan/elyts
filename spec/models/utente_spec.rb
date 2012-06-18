# == Schema Information
#
# Table name: utenti
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  salt            :string(255)
#  confirmed       :boolean         default(FALSE)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

require 'spec_helper'

describe Utente do
 
  before do
    
    @utente = Utente.new name:"Domenico D'Egidio",
                         email:"domenico@permacultura.it",
                         password:"password",
                         password_confirmation:"password"
  end
 
  subject{@utente} 
  
  let(:utente_valido) do
    Factory.create(:utente)
  end
  
  
  it "should respond to name" do
    @utente.should respond_to(:name)
  end
 
  it "should respond to email" do
    @utente.should respond_to(:email)
  end 
  
  it "should respond to password_digest" do
    @utente.should respond_to(:password_digest)
  end
  
  it "should respond to password" do
    @utente.should respond_to(:password)
    
  end
  
   it "should respond to password_confirmation" do
    @utente.should respond_to(:password_confirmation)
    
  end

  it "should respond to authenticate" do
    
    Utente.should respond_to(:authenticate)
    
  end
   
  it "should respond to remember_token" do
    
    subject.should respond_to(:remember_token)
    
  end
  
  context "when name is blank" do
    
    it "should not be valid" do
      @utente.name='' 
      @utente.should_not be_valid 
    end
    
    it "should not be valid" do
      @utente.name=nil   
      @utente.should_not be_valid 
    end
    
    # NON È NECESSARIO NOMINARE SEMPRE @utente: POSSIAMO UTILIZZARE subject OPPURE NIENTE !!
    
    it "should not be valid" do
      subject.name="     "    
      subject.should_not be_valid 
    end
    
  end
 
  context "when email is blank" do
    
    it "should not be valid" do
      subject.email=""
      should_not be_valid # <== Si noti non ho specificato su chi deve agire should() per default è il    
    end                   #     subect specificato
    
    it "should not be valid" do
      subject.email=nil
      should_not be_valid    
    end
    
    it "should not be valid" do
      subject.email="        "
      should_not be_valid    
    end
    
  
  end
 
  context "when email format is invalid" do
    
    it "should not be valid" do
      addresses = %w(domenico domenico@ domenico@email domenico@email. domenico_email.it)
      
      addresses.each do |addr|
       subject.email=addr
       should_not be_valid      
        
      end
    
    end
  
  end
 
 
  context " with an email that is already taken" do
   
    it "should be not valid" do
      @another_user = @utente.dup
      @another_user.email.upcase!
      subject.save
      @another_user.should_not be_valid
    end
     
  end 
 
 
 
  context " with a blank password" do
  
    it "should not be valid" do
      subject.password=subject.password_confirmation=""
      should_not be_valid
    end
  
    it "should not be valid" do
      subject.password=subject.password_confirmation=nil
      should_not be_valid
    end
    
     it "should not be valid" do
      subject.password=subject.password_confirmation="        "
      should_not be_valid
    end
  
  end
   
   
  
  context " with a password that don't match password confirmation" do
    
    it "should not be valid" do
      subject.password_confirmation="do not confirm"    
      should_not be_valid
    
    end 
  
  end 
 
  
  
  context " with a blank password and a blank password confirmation " do
  
    it "should not be valid" do
      subject.password_confirmation=subject.password=nil
      should_not be_valid  
    end
    
    it "should not be valid" do
      subject.password_confirmation=subject.password=""
      should_not be_valid  
    end
    
     it "should not be valid" do
      subject.password_confirmation=subject.password="  "
      should_not be_valid  
    end
      
  end
 
  
  
  context " with a password that is too short" do
    
    it "should not be valid" do
      subject.password_confirmation=subject.password = "X"*7
      should_not be_valid 
    end
  
  end 
 
 
 # authenticate tests
 
 
  context "with a valid email and password " do
    
    it "should be successfully authenticated" do
      Utente.authenticate(utente_valido.email,utente_valido.password).should_not be_nil
         
    end
  
  end
 
  
  
  context "with a valid email but invalid password" do
      it "should be not valid" do
         Utente.authenticate(utente_valido.email,'fooobarre').should be_nil
      end
  end 
  
  
  
  context "with an invalid email but valid password" do
      it "should be not valid" do
         Utente.authenticate('fooobarre@foo.com',utente_valido.password).should be_nil
      end
  end 
 
  
  
  context "with an invalid email and invalid password" do
      it "should be not valid" do
         Utente.authenticate('fooobarre@foo.com','fooofoooofooooooooo').should be_nil
      end
  end 
  
  
  context " with a blank remember token after saving" do
    
    before do
      subject.save
    end
    
    its(:remember_token){ should_not be_blank}
  
  end
  
end
