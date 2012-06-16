Feature: Create product
	Come amministratore
	Voglio inserire prodotti per la vendita
	In modo che gli utenti buyer del negozio possano fare shopping

Background:
 
  Given I am signed in as an administrator  
  Given I am on the homepage
  And I follow "Go to store admin"
  And I follow "Products"
  And I follow "Add new product"
  And I fill in "Product title" with "Cucumbers"
  And I fill in "Describe your product" with "Delicious vegetables used among other things, for the Tzazichi-Sauce"
  And I fill in "Selling price" with "1.50"
  And I fill in "Inventory" with "10"	 

Scenario: Create a product without attachment

 When I press "Create Product"
 Then I should see "Cucumbers was successful created! View it in your store or continue and create another product"


@javascript
Scenario: Creating a product with attachments
  And I follow "Add images to product"
  And I attach the file "spec/fixtures/snort.txt" to "product_assets_attributes_0_image"
  And I follow "Add images to product"
  And I attach the file "spec/fixtures/spinner.txt" to "product_assets_attributes_1_image"
  And I press "Create Product"
  Then I should see "Cucumbers was successful created! View it in your store or continue and create another product"
  
  

Scenario: Create a product with blank title
  And I fill in "Product title" with ""
  When I press "Create Product"
  Then I should see "Title can't be blank"
  And I should not see "Cucumbers was successful created! View it in your store or continue and create another product" 

Scenario: Create a product with an invalid price
  And I fill in "Selling price" with "NaN" 
  And I press "Create Product"
  Then I should see "Price is not a number"
  And I should not see "Cucumbers was successful created! View it in your store or continue and create another product" 

   