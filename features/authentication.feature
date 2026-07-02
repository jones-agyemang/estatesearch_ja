Feature: Authentication
  As a User
  In order to preserve confidentiality
  I want to be able to login into my own secure portal 

  Scenario: Register for a User account
    When I visit the login page
    And I enter my registration details
    Then I should be granted access

  Scenario Outline: Register for an account
    When I visit the registration page for type "<type>"
    And I register with email "<email>" and password "<password>"
    Then I should see notification "<notification>"

    Examples:
    | email                            | password | type   | notification                              |
    | lawyer.john.pearson@example.com  | s3kret   | lawyer | Welcome! You have signed up successfully. |
  
  Scenario Outline: Successful Login
    Given I registered with email "<email>" and password "<password>" as user of type "<type>"
    When I log in with email "<email>" and password "<password>"
    Then I should be granted access

    Examples:
    | email                            | password | type   |
    | lawyer.john.pearson@example.com  | s3kret   | lawyer |