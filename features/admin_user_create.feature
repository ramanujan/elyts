Feature: Create administrator user
  Come utente amministratore
  Voglio poter creare dei nuovi utenti anche amministratori con una comoda interfaccia
  Per poter ad esempio avere un nuovo collaboratore o per poter registrare un utente senza conferma
  
Background:  
  
  Given I am signed in as an administrator
  Given I am on the homepage
  
  And I follow "Go to store admin"
  And I follow "Users"
  And I follow "Add new user"
  And I fill in "Name" with "Wibble"
  And I fill in "Email address" with "new_admin@elyts.com"
  And I fill in "Password" with "password very valid"
  And I fill in "Confirm password" with "password very valid"
  
Scenario: Create administrator user
  And I check "Administrator user"
  When I press "Create User"
  Then I should see "Administrator new_admin@elyts.com was successfully created"
  
Scenario: Create a normal user
  When I press "Create User"
  Then I should see "Normal user new_admin@elyts.com was successfully created"