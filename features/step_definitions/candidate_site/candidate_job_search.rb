

Given(/^I am on candidate search job page$/) do
  @app.candidate_job_search.load
  expect(@app.candidate_job_search.category_search_link).to have_text('Search by Category')
end

When(/^I click on any listed job category$/) do
	@app.candidate_job_search.search_Job_category('Engineering')
  
	
end	

Then(/^Job details are displayed at composite search page$/) do
	@app.composite_search_page.has_search_jobs_result_table?
	
	end

And(/^I click on Custom Search link$/) do
   @app.candidate_job_search.goto_custom_search
   #@app.candidate_job_search.has_job_search_link?

end

When(/^I perform job search by Jobs Category and location$/) do
	@app.candidate_job_search.custom_job_search('Boston')

end

When(/^I perform job search by Job Category and location$/) do
	@app.candidate_job_search.custom_job_search('Cambridge')

end

And(/^I apply for given job$/) do
	@app.composite_search_page.open_Job
	@app.composite_search_page.apply_for_this_job
end

When(/^I see count of job for each category$/) do
    #jobcategcount = @app.candidate_job_search.get_CatJob_Size_List
    #for i in 1..jobcategcount
    	#@app.candidate_job_search.geteachJobresultcount(i)
    	#@app.candidate_job_search.job_search_link.click
    	
     #end
     @app.candidate_job_search.goto_custom_search

    end


Then(/^count of jobs should match at composite search page$/) do
     @app.candidate_job_search.custom_job_search('Boston')
     
     
end

   
