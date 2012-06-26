Feature: Seed data

  Come sistema 
  Voglio popolare il database con qualche dato
  In modo che l'applicazione possa avere qualche dato da manipolare
  

Scenario: Basic data
  Given I have run the seed task
  And I am signed in as "administrator@elyts.com"
  Then I should see "Logged as administrator@elyts.com"  
