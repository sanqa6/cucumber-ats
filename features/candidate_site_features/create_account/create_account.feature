@smoke


Feature: Create an account from login page
         A new account only be created,once user has selected a job for apply.


  Scenario: The account is successfully created
   Given I am on the candidate login page
   And I click on Create new account
   Then I should see an correct message as "You must select a job to register."

   


Scenario: Apply for a job through creating new account
   Given I am on candidate search job page
   And I click on Custom Search link
   When I perform job search by Jobs Category and location
   Then Job details are displayed at composite search page
   Then I apply for given job
   Then I should be redirected to login page
   And I click on Create new account
   When I create account with valid email and password
   Then I should be logged in


 Scenario: Create a new account with existing user details
  Given I am on candidate search job page
  And I click on any listed job category
  Then Job details are displayed at composite search page
  Then I apply for given job
  Then I should be redirected to login page
  And I click on Create new account
  When I create account using existing user email and password
Then I should see an correct message as "You already have an account with us, or another candidate has already taken this account name."

  Scenario: Create a new account with invalid username and valid password
  Given I am on candidate search job page
  And I click on any listed job category
  Then Job details are displayed at composite search page
  Then I apply for given job
  Then I should be redirected to login page
  And I click on Create new account
  When I create account with invalid email and valid passwords
  Then I should see an correct message as "Invalid E-mail format."
  


  Scenario: Create a new account with invalid username and invalid password
  Given I am on candidate search job page
  And I click on any listed job category
  Then Job details are displayed at composite search page
  Then I apply for given job
  Then I should be redirected to login page
  And I click on Create new account
  When I create account with valid email and invalid passwords
  Then I should see an correct message as "Password and Password Confirm must match."

  
  










    



   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   #Scenario: The account is not created because password mismatched
 # Given I am on the external site
#When I create and account with valid email and invalid passwords
 # Then I should see an error message

#Scenario: The account is not created because the email is not a valid email
 # Given I am on the external site
 # When I create and account with invalid email and valid passwords
 # Then I should see an error message
