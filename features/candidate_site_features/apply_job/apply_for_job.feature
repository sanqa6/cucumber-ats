@smoke

Feature: completion of apply for a job with new account

   
Scenario: apply for a complete level job through creating new account
   Given I am on candidate search job page
   And I click on Custom Search link
   When I perform job search by Jobs Category and location
   Then Job details are displayed at composite search page
   Then I apply for given job
   Then I should be redirected to login page
   And I click on Create new account
   When I create account with valid email and password
   Then I should be logged in
   And I Apply for a complete job
   Then I should be able to apply for complete job successfully
   And I do logout of candidate site
   Given I am on the candidate login page
   When I sign in candidate site
   Then I should be logged in
   Then I should be able to apply for complete job successfully
    





Scenario: apply for a summary level job through creating new account
   Given I am on candidate search job page
   And I click on Custom Search link
   When I perform job search by Job Category and location
   Then Job details are displayed at composite search page
   Then I apply for given job
   Then I should be redirected to login page
   And I click on Create new account
   When I create account with valid email and password
   Then I should be logged in
   And I Apply for a summary job
   Then I should be able to apply for summary job successfully
   And I do logout of candidate site
   Given I am on the candidate login page
   When I sign in candidate site
   Then I should be logged in
   Then I should be able to apply for summary job successfully







