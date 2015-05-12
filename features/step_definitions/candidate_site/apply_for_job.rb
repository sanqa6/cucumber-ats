

And(/^I Apply for a complete job$/) do

	@app.apply_for_job_page.fill_apply_for_job_form
end

And(/^I Apply for a summary job$/) do
	@app.apply_for_job_page.fill_summary_application_details
end

Then(/^I should be able to apply for complete job successfully$/) do

   expect(@app.my_account_info_page.applied_job_title).to have_text('QA HR Automation')

end

Then(/^I should be able to apply for summary job successfully$/) do

   expect(@app.my_account_info_page.applied_job_title).to have_text('QA Test01 Engineer')


end

And(/^I answer No for "(.*?)" question$/) do |questionlevel|
	@app.apply_for_job_page.fill_screen_out_application_details(questionlevel)

end

Then(/^I should see screened out message as "(.*?)"$/) do |mesg|
    expect(@app.apply_for_job_page.screen_out_mesg).to have_text(mesg)
 
end

Then(/^I should see job level screened out message as "(.*?)"$/) do |mesg|
    expect(@app.apply_for_job_page.job_level_screen_out_mesg).to have_text(mesg)
 
end	

And(/^I edit the job successfully$/) do
	


@app.my_account_info_page.edit_candidate_profile

end

And(/^I edit the summary job successfully$/) do
	@app.my_account_info_page.click_edit_profile

    @app.my_account_info_page.edit_personal_Information

    @app.my_account_info_page.submit_edit_profile

end



