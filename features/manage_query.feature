@sign_in_user
@sign_out
Feature: Manage User Questions
    As a User
    In order to solicit legal advice
    I want to be able to submit my query

    Background: Submit query
        When I visit the legal advice board

    Scenario Outline: Submit query with valid details
        And I enter a question with title "<title>", body "<body>" and category "<category>"
        Then I should see notification "<notification>"

        Examples:
            | title    | body                        | category     | notification               |
            | Freehold | I need help with deed terms | Property law | Query successfully raised! |

    Scenario Outline: Submit query with invalid details
       And I enter a question with title "<title>", body "<body>" and category "<category>"
       Then I should see notification "<notification>"

       Examples:
            | title    | body                        | category     | notification             |
            |          | I need help with deed terms | Property law | Title can't be blank     |
            | Freehold |                             | Property law | Body can't be blank      |
            | Freehold | I need help with deed terms |              | Category can't be blank  |

    Scenario Outline: Status > Freshly Submitted Query
       And I enter a question with title "<title>", body "<body>" and category "<category>"
       Then I should see status as "<status>"

       Examples:
           | title    | body                        | category     | notification               | status |
           | Freehold | I need help with deed terms | Property law | Query successfully raised! | open   |
