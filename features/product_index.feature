Feature: Accessing a product's list
  Come amministratore
  Voglio poter visualizzare una lista di tutti i prodotti
  
Scenario: Show a product
  Given I am signed in as an administrator
  Given there is a product named "Cucumbers"
  And there is a product named "Strawberries"
  And there is a product named "Cherries"
  And I am on the homepage
  And I follow "Go to store admin"
  And I follow "Products"
  Then I should see "Cucumbers"
  And I should see "Strawberries"
  And I should see "Cherries"
  