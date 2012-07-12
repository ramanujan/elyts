Feature: Adding a product to cart

  Come utente buyer
  Voglio poter inserire un prodotto nel carrello
  In modo da poterlo acquistare 

Background: 
  Given I am on the homepage
  And there is a product named "Cucumbers" 

Scenario: Add a product to a cart
  
  And I follow "CATALOG"
  And I follow "All Products"
  When I follow "Cucumbers"
  And I follow "Add To Cart"
  Then I should see "Shopping cart"
  And I should see "Continue Shopping"
  And I should see "Save Changes"
  And I should see "Save & Checkout"
  And I should see "1 item in your shopping cart"
   
@javascript

Scenario: Add a product to a cart via ajax control
  And I follow "Cucumbers"
  When I follow "Add To Cart"
  Then I should see "1 item in your cart"
   