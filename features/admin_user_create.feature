Feature: Admin Create user	
  Come utente amministratore
  Voglio poter creare dei nuovi utenti anche amministratori con una comoda interfaccia
  Per poter ad esempio avere un nuovo collaboratore o per poter registrare un utente senza conferma
  
Scenario: Create user
  Given I am signed in as an administrator
  Given I am on the homepage
  And I follow "Go to store admin"
  And I follow 'Users'
  And I fill in "Name" with "Wibble"
  And I fill in "Email address" with "domenico@valid.com"
  And I fill in "Password" with "password very valid"
  And I fill in "Confirm password" with "password very valid"
  When I press "Join Us"
  Then I should see "Your account was successfully created!"
  And I should see "Please follow the instruction sended to your email and complete the signup process!"
  
  And "domenico@valid.com" should receive an email
  And "domenico@valid.com" opens the email with subject "Elyts account confirmation"
  And they should see "COMPLETE ACCOUNT CREATION PROCESS" in the email body
  When they follow "COMPLETE ACCOUNT CREATION PROCESS" in the email
  Then I should see "Your account creation process is completed. Welcome to Elyts!"
  
Scenario: Create an admin user
  