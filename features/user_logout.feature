Feature: Logout user
  Come utente autenticato
  Voglio poter essere in grado di eseguire il logout
  In modo da poter cancellare tutti i dati riguardanti la mia sessione

Background:  
  Given there are the following users:
  | email                      | admin       | 
  | normal@example.com         | false       | 
  | admin@example.com          | true        |
  

Scenario: Logout in a normal way (following the Logout link)  	
  And I am signed in as "normal@example.com"
  When I follow "Logout"
  Then I should see "Login"
  And I should see "Sign Up"
  And I should not see "Logout"

   