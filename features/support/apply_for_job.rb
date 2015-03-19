module Apply_For_Job
	def apply_for_job(job_title)
		fill_in('keywords', with: '"' + job_title + '"')
  		click_button('Search') 
  		find('tr', text: job_title).visible?
  		find('tr', text: job_title).click
  		click_link('Apply for This Job')
  		click_link('Confirmation')
  		click_link('submit')
  		page.has_content?('has been submitted')
  	end
end

World(Apply_For_Job)  	