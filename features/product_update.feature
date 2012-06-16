Feature: Update product
	Come amministratore
	Voglio poter editare i dati relativi ai prodotti in vendita tramite una comoda interfaccia
	In modo da poter aggiornare i dati sui prodotti in vendita 


Background: 
  Given I am signed in as an administrator
  Given there is a product named "Cucumbers"
  And I am on the homepage
  And I follow "Go to store admin"
  And I follow "Cucumbers"
  And I follow "Edit Product"

Scenario: Edit and Update a product
  And I fill in "Product title" with "Mega Cucumbers"
  And I fill in "Selling price" with "234"
  And I fill in "Inventory" with "100"
  When I press "Update Product"
  Then I should see "Mega Cucumbers was successful updated! View it in your store or continue"  
   

  