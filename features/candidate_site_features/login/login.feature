@smoke @regression @login @pollinator @javascript

Feature: Candidate site login
  As a candidate
  I want to login candidate site
  So that I can apply job

  #External site

  Scenario:  A candidate can login external site
    Given I have a valid external candidate account
    Given I am on the candidate login page
    When I sign in candidate site
    Then I should be logged in

  Scenario: candidate is not logged in with invalid credentials
  
    Given I am on the candidate login page
    And I login with invalid email and password
    Then I should not be logged in
    And I should see an correct message as "Please re-enter your username and password if you are already a registered user."

    


  