@sign_in_user
@sign_out
Feature: Payment Flow
    As a User
    In order to access quality advice
    I want to be able to procure curated responses

    Scenario: Approve Payment
        Given I have a question with a response
        When I approve payment to unlock response
        Then I should see response
