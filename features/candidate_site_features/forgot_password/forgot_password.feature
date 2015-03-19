Feature: when a candidate forget his login password,
         he should be able to retrieve password 
         using forgot password functinality.

Scenario: candidate successfully reset its password using forgot password
Given I am on the candidate login page
And I perform forgot password action using existing email "santestqa@test.com"
Then I should see an correct message as "E-mail has been sent to  santestqa@test.com"

Scenario: candidate successfully reset its password using forgot password
Given I am on the candidate login page
And I perform forgot password action using nonexisting email "santestxyz@test.com"
Then I should see an correct message as "You don't have an account with us."





