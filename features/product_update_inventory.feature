Feature: Update inventory field
  Come amministratore
  Voglio poter accedere ad una lista di prodotti
  In modo da poter scegliere di aggiornare la quantità disponibile per quel prodotto
  
@javascript
Scenario: Update inventory
  Given I am signed in as an administrator
  Given there is a product named "Cucumbers"
  And I am on the homepage
  And I follow "Go to store admin"
  And I follow "Products"
  And I fill in "inventory" with "100"
  And I press "Update Inventory"
  Then I should see "Inventory successful updated!"
 