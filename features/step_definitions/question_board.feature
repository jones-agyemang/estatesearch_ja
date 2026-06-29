Feature: Manage User Questions
    As a User
    In order to solicit legal advice
    I want to be able to submit my query

    Scenario: Sucessfully submit a query
        When I visit the legal advice board
        And I enter valid query details
        Then I should receive a notification of success
