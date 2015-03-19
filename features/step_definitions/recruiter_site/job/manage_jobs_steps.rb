When(/^I am on Manage Jobs page$/) do
  @app.recruiter_manage_jobs.load
end

Then(/^I should be able to see the Manage Job page$/) do
  expect(@app.recruiter_manage_jobs.search_filters).to eq(["Job ID", "Recruiter", "Status *", "Job Code", "Job Title", "Location"])
  expect(@app.recruiter_manage_jobs.job_list_columns).to eq(['Job ID', 'Recruiter', 'Job Code', 'Location', 'Job Title', 'Posted', 'Apps', 'Candidates', 'Openings', 'Hired', 'Status', 'View'])
end

When(/^I am on the Draft Jobs page$/) do
  @app.recruiter_draft_jobs.load
end

Then(/^I should be able to see the Draft Jobs page$/) do
  expect(@app.recruiter_draft_jobs.page_title).to have_text('Draft Jobs')
  expect(@app.recruiter_draft_jobs.job_list_columns).to eq(['Job ID', 'Job Code', 'Location', 'Job Title', 'Status', 'Create Date', 'Delete'])
end

When(/^I am on the Approve Jobs page$/) do
  @app.recruiter_approve_jobs.load
end

Then(/^I should be able to see the Approve Jobs page$/) do
  expect(@app.recruiter_approve_jobs.page_title).to have_text('Approve Jobs')
  expect(@app.recruiter_approve_jobs.search_handle).to have_text('Filter Approval Job List')
  expect(@app.recruiter_approve_jobs.job_list_columns).to eq(['Job ID', 'Job Title', 'Received', 'Inbox', 'First Name', 'Last Name'])
end
