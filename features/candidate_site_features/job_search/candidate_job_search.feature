
Feature:Job search by job category search
        and using custom serach also.
        

Scenario:select any listed job category at search jobs page and view job details		
   Given I am on candidate search job page
	When I click on any listed job category
	Then Job details are displayed at composite search page



Scenario:perform custom jobs search and view job details
   Given I am on candidate search job page
   And I click on Custom Search link
   When I perform job search by Jobs Category and location
   Then Job details are displayed at composite search page
   And I apply for given job
   Then I should be redirected to login page


		
		
		
		
Scenario:verify if counts of job under each category is same as respective job's coposite page count
Given I am on candidate search job page
When I see count of job for each category
Then count of jobs should match at composite search page




	