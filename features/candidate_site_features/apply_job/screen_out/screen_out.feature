
Feature: Validate screening level screen out messsage


Scenario: Apply for a job with new candidate registered and validate pre screening question level screen out
   Given I am on candidate search job page
   And I click on Custom Search link
   When I perform job search by Job Category and location
   Then Job details are displayed at composite search page
   Then I apply for given job
   Then I should be redirected to login page
   And I click on Create new account
   When I create account with valid email and password
   Then I should be logged in
   And I answer No for "screening level" question
   Then I should see screened out message as "Sorry! Based on your answers to the previous questions you are not qualified to work for our company."





Scenario: Apply for a job with new candidate registered and validate job question level screen out
   Given I am on candidate search job page
   And I click on Custom Search link
   When I perform job search by Job Category and location
   Then Job details are displayed at composite search page
   Then I apply for given job
   Then I should be redirected to login page
   And I click on Create new account
   When I create account with valid email and password
   Then I should be logged in
   And I answer No for "job question level" question
   Then I should see job level screened out message as "Screen Outtest"


   





   
