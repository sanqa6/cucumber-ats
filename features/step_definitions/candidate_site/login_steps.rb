

# Either have per-config account or create account on the fly
# TODO : Create account on the fly to reduce configuration and enhance test case isolation
Given(/^A valid external candidate account exists$/) do
  @candidate = Candidate.new
  @candidate.email = CONFIG['EXTERNAL_CANDIDATE_EMAIL']
  @candidate.password = CONFIG['EXTERNAL_CANDIDATE_PASSWORD']
end

Given(/^A valid internal candidate account exists$/) do
  @candidate = Candidate.new
  @candidate.email = CONFIG['INTERNAL_CANDIDATE_EMAIL']
  @candidate.password = CONFIG['INTERNAL_CANDIDATE_PASSWORD']
end

When(/^I sign in candidate site$/) do
  @app.candidate_site_login_page.login(@candidate.email,@candidate.password)
  
end
When(/^I sign in candidate site with existing account$/) do
  @app.candidate_site_login_page.login("9774.raul@example.com","3iw18q5q52w")

end

Then(/^I should be redirected to login page$/) do
  @app.candidate_site_login_page.has_username?

end

Then(/^I should be logged in$/) do
  @app.candidate_site_login_page.wait_for_logout
  #expect(@app.candidate_site_login_page.loggedin?).to be true
end

And(/^I login with invalid email and password$/) do
  @candidate = Candidate.new
  @candidate.email = Faker::Internet.email
  @candidate.password = Faker::Internet.password(20,30)
  @app.candidate_site_login_page.login(@candidate.email,@candidate.password)
end

Then(/^I should not be logged in$/) do
  expect(@app.candidate_site_login_page.loggedin?).to be false
end

  
Given(/^I don't have a valid account$/) do
  @candidate = Candidate.new
  @candidate.email = Faker::Internet.email
  @candidate.password = Faker::Internet.password(20,30)
  @candidate.first_name = Faker::Name.first_name
  @candidate.last_name = Faker::Name.last_name
  @candidate.job_title = Faker::Name.title
  @candidate.employer = Faker::Company.name
  @candidate.address = 'Auckland'     #avoid pollinator address validation
end

Given(/^I have a valid external candidate account$/) do
  step 'A valid external candidate account exists'
end

Given(/^I have a valid internal candidate account$/) do
  step 'A valid internal candidate account exists'
end

And(/^I am on external candidate site login page$/) do
  @context.site = :external
  @app.external_site_login_page.load
end





Then(/^I should see login failure error message$/) do
  expect(@app.external_site_login_page.error_message).to be_truthy
end

Then(/^I should be redirect to home page$/) do
  step 'I should be redirect to internal home page' if @context.internal?
  step 'I should be redirect to external home page' if @context.external?
end

Then(/^I should be redirect to internal home page$/) do
  @app.internal_site_home_page.wait_for_user_button
  @app.internal_site_home_page.should be_displayed
end

Then(/^I should be redirect to external home page$/) do
  @app.external_site_home_page.wait_for_user_button
  @app.external_site_home_page.should be_displayed
end


When(/^I login to internal site$/) do
  @context.site = :internal
  @app.internal_site_home_page.load
  @app.internal_site_home_page.login(@candidate.email,@candidate.password)
end

When(/^I login to external site$/) do
  @context.site = :external
  @app.external_site_home_page.load
  @app.external_site_home_page.login(@candidate.email,@candidate.password)
end


Then(/^Pollinator should be pop up$/) do
  expect(@app.external_site_home_page.pollinator_popup?).to be true
end

When(/^I login pollinator with manual option$/) do
  manual_complete_pollinator @candidate.email
end

Then(/^I should be redirect to external login page$/) do
  @app.external_site_login_page.wait_for_password
  @app.external_site_login_page.should be_displayed
end

And(/^The email address should not be allowed to modify$/) do
  expect(@app.external_site_login_page.username_disabled?).to be true
end

And(/^I have redirected to external login page from pollinator$/) do
  step 'I login to external site'
  step 'I login pollinator with manual option'
end

When(/^I sign in$/) do
  @app.external_site_login_page.login @candidate.email, @candidate.password if @context.external?
  @app.internal_site_login_page.login @candidate.email, @candidate.password if @context.internal?
end

Then(/^I should be asked to submit information$/) do
  verify_and_register_pollinator @candidate.first_name,@candidate.last_name, @candidate.job_title,@candidate.employer,@candidate.address
end

And(/^I submit register information to pollinator$/) do
  verify_and_register_pollinator @candidate.first_name,@candidate.last_name, @candidate.job_title,@candidate.employer,@candidate.address
end

And(/^I have redirected to external login page from pollinator after complete pollinator register form$/) do
  step 'I login to external site'
  step 'I login pollinator with manual option'
  step 'I submit register information to pollinator'
end

When(/^I sign in with wrong password$/) do
  @app.external_site_login_page.login @candidate.email, "#{@candidate.password} make it wrong"
end

Then(/^I should be redirect to create account page$/) do
  expect(@app.candidate_create_account.current_page?).to be true
end

And(/^I have redirected to internal login page from pollinator$/) do
  step 'I login to internal site'
  step 'I login pollinator with manual option'
end

Given(/^I have logged in external candidate site$/) do
  step 'I login to external site'
  step 'I login pollinator with manual option'
  step 'I sign in'
end

Given(/^I have logged in internal candidate site$/) do
  step 'I login to internal site'
  step 'I login pollinator with manual option'
  step 'I sign in'
end