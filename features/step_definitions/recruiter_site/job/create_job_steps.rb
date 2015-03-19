And (/^I have created a job displayed on both sites$/) do
  step "I have created an internal and external job"
  step "I should find that job on both sites"
end

Then(/^that job should be displayed$/) do
 page.should have_css('tr', text: @unique_job_title)
end

Then(/^that job should not be displayed$/) do
  page.should have_no_css('tr', text: @unique_job_title)
end

Given /^I am logged in as a "(.*?)" in the recruiter site$/ do |role|
  case role
    when "admin"
    @app.recruiterLogin.login_to_recruiter(CONFIG["ADMIN"], CONFIG["ADMIN_PASSWORD"])
    when "recruiter"
    @app.recruiterLogin.login_to_recruiter(CONFIG["RECRUITER"], CONFIG["RECRUITER_PASSWORD"])
    when "hiring manager"
    @app.recruiterLogin.login_to_recruiter(CONFIG["HM"], CONFIG["HM_PASSWORD"])
  end
end

Given /^I am in Create Job page$/ do
  @app.recruiterCreateJob.load
  @app.recruiterCreateJob.wait_for_add_button
end

When /^I click the Add$/ do
  @app.recruiterCreateJob.add_button.click
end

Then /^I should be able to create and save a job template with the following data:$/ do |table|
   jobDataTemplate = table.rows_hash
   test_context[:newTemplateName] = @app.recruiterCreateJob.fill_in_job_form :template => jobDataTemplate["Template"],
          :job_title => (jobDataTemplate["Job Title"])+" "+Time.now.strftime("%d-%m-%Y %H:%M:%S")
  print 'Debugging job template created: '+(test_context[:newTemplateName])
end

Then /^I should (be|not be) able to search for the created job template$/ do |condition|
  case condition
    when "be"
    @app.recruiterCreateJob.search_template(test_context[:newTemplateName])
    test_context[:newTemplateName].should == @app.recruiterCreateJob.find_in_table_template_name(test_context[:newTemplateName])
    when "not be"
    @app.recruiterCreateJob.search_template(test_context[:deletedTemplateName])
    page.should have_no_selector('tr', :text => test_context[:deletedTemplateName])
  end
end

When /^I click the Add button$/ do
  @app.recruiterCreateJob.add_button.click
end

Then /^I should be able to create and submit the requisition with the following data:$/ do |table|
  jobData = table.rows_hash
  test_context[:newJobName] = @app.recruiterCreateJob.fill_in_job_form :template => jobData["Template"],
          :job_title => (jobData["Job Title"])+" "+Time.now.strftime("%d-%m-%Y %H:%M:%S"),
          :position_type => jobData["Position Type"],
          :number_of_position => jobData["Number of Position"],
          :job_description => jobData["Job Description"],
          :job_requirement => jobData["Job Requirement"],
          :zip_code => jobData["Zip Code"],
          :offer_template =>jobData["Offer Template"],
          :organizational_unit => jobData["Organizational Unit"],
          :post_type => jobData["Post Type"],
          :select_application_flow => jobData["Select Application Flow"],
          :category => jobData["Category"],
          :job_screening_questions => jobData["Job Screening Questions"],
          :screened_in_message => jobData["Screened In Message"],
          :screened_out_message => jobData["Screened Out Message"],
          :default_application_status => jobData["Default Application Status"]
  print 'Debugging job created: '+(test_context[:newJobName])
end

And /^See the created requisition in Manage Jobs page with status "(.*?)"$/ do |status|
  @app.recruiter_manage_jobs.load
  print 'Debugging find job created in manage jobs: '+(test_context[:newJobName])
  status.should == @app.recruiter_manage_jobs.search_find_job_and_get_status(test_context[:newJobName])
end

When /^I click the "(.*?)" icon from an existing template$/ do |action| # actions: "Use", "Delete"
  @existing_job_template = CONFIG["EXISTING_JOB_TEMPLATE"] # This job template should be present.
  case action
  when "Delete" || "delete"
    action = '.delete'
    @app.recruiterCreateJob.load
    @app.recruiterCreateJob.wait_for_add_button
    @app.recruiterCreateJob.search_template(test_context[:newTemplateName])
    begin
      find('tr', :text => test_context[:newTemplateName]).find(action).click
    rescue Capybara::ElementNotFound # if the template pass is nil or cannot be found create one for deletion
      @app.recruiterCreateJob.add_button.click
      test_context[:deletedTemplateName] = "AT New Template to Delete"
      @app.recruiterCreateJob.fill_in_job_form :template => "Yes", :job_title => test_context[:deletedTemplateName]
      @app.recruiterCreateJob.search_template(test_context[:deletedTemplateName])
      find('tr', :text => test_context[:deletedTemplateName]).find(action).click
    end

  when "Use" || "use"
    action = '.use'
    @app.recruiterCreateJob.load
    @app.recruiterCreateJob.wait_for_add_button
    @app.recruiterCreateJob.search_template(@existing_job_template)
    begin
      find('tr', :text => @existing_job_template).find(action).click
    rescue Capybara::ElementNotFound # if expected existing template cannot be found, auto test will recreated the template
      @app.recruiterCreateJob.add_button.click
      @app.recruiterCreateJob.fill_in_job_form :template => "Yes", :job_title => @existing_job_template
      @app.recruiterCreateJob.search_template(@existing_job_template)
      find('tr', :text => @existing_job_template).find(action).click
    end
  end
end

Then /^I should be able to click "(.*?)" button for the requisition$/ do |action|
  test_context[:newJobName] = "AT Job from template "+Time.now.strftime("%d-%m-%Y %H:%M:%S")
  find('#title').set(test_context[:newJobName])
  click_on(action)
  wait_for_ajax
end
