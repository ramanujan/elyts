Feature: Accessing a product from a list
  Come amministratore
  Voglio poter accedere ad una lista di prodotti
  In modo da poter sceglierne uno in particolare per gestirlo

Scenario: Show a product
  Given there is a product named "Cucumbers"
  And I am on the homepage
  And I follow "Go to store admin"
  And I follow "Products"
  When I follow "Cucumbers"
  Then I should see "Edit Product" within "a"
  And I should see "Delete Product" within "a"
  And I should see "$1.50"
  

