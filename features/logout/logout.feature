Feature: user logout of Candidate site
  As a candidate
  I want to logout of candidate site sucessfully.
  

  #External site

  Scenario:  A logged in candidate can logout of candidate site
    Given I have a valid external candidate account
    Given I am on the candidate login page
    When I sign in candidate site
    Then I should be logged in
    When I do logout of candidate site
    Then I should be logged out of candidate site

    

