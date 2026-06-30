Feature: Authentication
  As a User
  In order to preserve confidentiality
  I want to be able to login into my own secure portal 

  Scenario: Register for an account
    When I visit the login page
    And I enter my registration details
    Then I should be granted access
  
  Scenario Outline: Successful Login
    Given I registered with email "<email>" and password "<password>" as user of type "<type>"
    When I log in with email "<email>" and password "<password>"
    Then I should be granted access

    Examples:
    | email                            | password | type   |
    | lawyer.john.pearson@example.com  | s3kret   | lawyer |