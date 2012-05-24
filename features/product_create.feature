Feature: Create product
	Come amministratore
	Voglio inserire prodotti per la vendita
	In modo che gli utenti buyer del negozio possano fare shopping
	
Scenario: Create a product in a normal way
  Given I am on the homepage
  And I follow "Go to store admin"
  And I follow "Products"
  And I follow "Add new product"
  And I fill in "Product title" with "Cucumbers"
  And I fill in "Describe your product" with "Delicious vegetables used among other things, for the Tzazichi-Sauce"
  And I fill in "Selling price" with "1.50"
  And I fill in "Inventory" with "10"	 
  When I press "Create Product"
  Then I should see "Cucumbers was successful created! View it in your store or continue and create another product"

