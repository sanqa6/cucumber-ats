
When(/^A candidate is on home page$/) do
	@app.candidate_home_page.load

	end	

Then(/^All Navigational UI elements are visible$/) do
	@app.candidate_home_page.has_job_search_link?
	@app.candidate_home_page.has_login_link?
	@app.candidate_home_page.has_help_link?
	
	end