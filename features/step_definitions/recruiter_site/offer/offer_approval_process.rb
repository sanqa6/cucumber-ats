Given(/^I have an offer approval process$/) do
  manage_offer_approval_process = "recruiter manage offer approval process"
  @title = "1#{Faker::Name.title}-#{Random.rand(100000)}"
  step "I am on page \"#{manage_offer_approval_process}\""
  @app.recruiter_offer_approval_process.click_create_button
  @app.recruiter_offer_approval_process_create.set_name(@title)
  step "I select an approver named \"Panda Mars\""
  step "I select an approver named \"tyler holbrook\""
  @app.recruiter_offer_approval_process_create.create
  step "the url starts with \"#{manage_offer_approval_process}\""
end

When(/^I create an offer approval process$/) do
  step "I have an offer approval process"
end

Then(/^This offer approval process should exist$/) do
  @app.recruiter_offer_approval_process.row_is_present?(@title)
end

And(/^I select an approver named "(.*?)"$/) do |approver|
  @app.recruiter_offer_approval_process_create.select_approver(approver)
  expect(@app.recruiter_offer_approval_process_create.approver_is_listed?(approver)).to be_truthy
end

When(/^I edit the title of this offer approval process$/) do
  sleep 1
  @app.recruiter_offer_approval_process.edit_approval_process(@title)
  @title = "1#{Faker::Name.title}-#{Random.rand(100000)}"
  @app.recruiter_offer_approval_process_create.set_name(@title)
  @app.recruiter_offer_approval_process_create.edit
  step "the url starts with \"recruiter manage offer approval process\""
  expect(@app.recruiter_offer_approval_process.row_is_present?(@title)).to be_truthy, "the approval process #{@title} is not present."

end
