Feature: Access Management
  As an EstateSearch account holder
  I want dashboards to be restricted by account type
  So that only authorised users can access lawyer workflows

  Scenario: Lawyer accesses the lawyer dashboard
    Given I am signed in as a lawyer
    When I visit the lawyer dashboard
    Then I should see the lawyer dashboard

  Scenario: Non-lawyer is blocked from the lawyer dashboard
    Given I am signed in as a user
    When I visit the lawyer dashboard
    Then I should be redirected to my user dashboard
    And I should see that the lawyer dashboard is restricted to lawyers
