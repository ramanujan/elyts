Feature: Create user	
  Come utente normale
  Voglio poter eseguire la registrazione presso l'applicazione con una comoda interfaccia
  Per poter in seguito autenticarmi e fare shopping
  
Scenario: Sign up

  Given I am on the homepage
  And I follow "Sign Up"
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