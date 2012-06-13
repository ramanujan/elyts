Feature: Login user
  Come utente registrato e confermato
  Voglio poter essere in grado di eseguire il login, tramite una comoda interfaccia
  In modo da potermi autenticare presso l'applicazione

Background:  
  Given there are the following users:
    | email                    | confirmed   |
    | confirmed@example.com    | true        |
    | unconfirmed@example.com  | false       |
    
Scenario: Login throught a form ( with steps grouped in one big step! )  	
  And I am signed in as "confirmed@example.com"
  Then I should see "Logout"
  
Scenario: Login throught a form providing invalid data
  Given I am on the homepage 
  When I follow "Login" 
  And I fill in "Email" with "confirmed@example.com"  
  And I fill in "Password" with "invalid password" 
  And I press "Login"
  Then I should see "Authentication error"      