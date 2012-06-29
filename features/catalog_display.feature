Feature: Catalog display
  
Come utente normale
Voglio poter accedere ad un catalogo di prodotti
In modo da poter scegliere un prodotto da inserire nel carrello della spesa

@javascript

Scenario: View all products
  Given there is a product named "Faberge Egg"
  And there is a product named "Popinga"
  And I am on the homepage
  When I follow "CATALOG"
  And I follow "All Products"
  Then I should see "Faberge Egg" 
  And I should see "1.50"
  And I should see "Popinga"
  
