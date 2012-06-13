Given(/^I am signed in as "([^"]*)"$/) do |email|
  steps %Q{ Given I am on the homepage 
            When I follow "Login" 
            And I fill in "Email" with "#{email}"  
            And I fill in "Password" with "super valid password" 
            And I press "Login" 
            Then I should see "Logged as #{email}" 
           }
end


Given /^there is the user "([^"]*)"$/ do |email|
  @user = Factory.create(:utente,email:email) 
end


Given(/^there are the following users:$/) do |table|
  # table is a Cucumber::Ast::Table

  @users=[]
  table.hashes.each do |attributes|
=begin 
  
  ATTENZIONE!!!! confirmed è String che contiene true/false (viene da un file di testo)
  Ricorda che delete() ritorna il valore dell'attributo e lo cancella dall'Hash. 
  Ritorna nil se non viene trovata la chiave
      
=end
    confirmed = attributes.delete("confirmed")  
    @user= Factory.create(:utente,attributes)
    #@user.update_attribute(:admin,(attributes[:admin]=='true'))   
    @user.confirm! if (confirmed.nil?) || (confirmed=='true')
    @users << @user
    p "_____________________________________________________"
    p Utente.find_by_email(@user.email)
  end
  p "@users=========>#{@users}"
end


