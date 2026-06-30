Feature: Lawyer Dashboard
    As a Lawyer
    I want to be able to view questions
    In order to provide a response
    
    Background:
        Given there are open questions
    
    @sign_out
    Scenario Outline: View Open Questions
        Given I registered with email "<email>" and password "<password>" as user of type "<type>"
        When I log in with email "<email>" and password "<password>"
        And I visit the legal advice board
        Then I should be able to see the open questions

        Examples:
        | email                            | password | type   |
        | lawyer.john.pearson@example.com  | s3kret   | lawyer |

    @sign_in_lawyer
    Scenario: Respond to Open Questions
        When I visit the legal advice board
        And I provide a response to a question
        Then I should see notification "<notification>"

        Examples:
        | notification                     |
        | Successfully submitted response. |
