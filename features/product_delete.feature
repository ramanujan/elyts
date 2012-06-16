Feature: Delete product
	Come amministratore
	Voglio poter cancellare i prodotti non più in vendita, in maniera semplice tramite un pulsante 
	In modo che gli utenti buyer possano scegliere solo i prodotti disponibili

Scenario: 

   Given I am signed in as an administrator 
   Given there is a product named "Cucumbers"
   And I am on the homepage
   And I follow "Go to store admin"
   And I follow "Products"
   And I follow "Cucumbers"
   When I follow "Delete Product"
   Then I should see "Cucumbers was successful deleted!"
   And I should not see "Cucumbers" within "h2"
   