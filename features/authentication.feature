Feature: Authentication
  As a User
  In order to preserve confidentiality
  I want to be able to login into my own secure portal 

  Scenario: Register for an account
    When I visit the login page
    And I enter my registration details
    Then I should be granted access
  
  Scenario: Successful Login
    Given I am a registered user
    When I log in with valid credentials
    Then I should be granted access