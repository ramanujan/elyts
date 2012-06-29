Feature: Adding a product to cart

  Come utente buyer
  Voglio poter inserire un prodotto nel carrello
  In modo da poterlo acquistare 

Scenario: Add a product to a cart

  Given I am on the homepage
  And there is a product named "Cucumbers" 
  And I follow "CATALOG"
  And I follow "All Products"
  When I follow "Cucumbers"
  And I follow "Add To Cart"
  Then I should see "Shopping cart"
  And I should see "Continue shopping"
  And I should see "Save Changes"
  And I should see "Save & Checkout"
  And I should see "1 item in your shopping cart"
   
  