
Given(/^I am on the candidate login page$/) do
  @app.candidate_site_login_page.load
  end

And(/^I click on Create new account$/) do
  @app.candidate_site_login_page.create_account_link.click
  @app.candidate_site_login_page.wait_for_username_input
end

Then(/^I am asked to select a job first$/) do
  expect(@app.candidate_site_login_page.message).to have_text('You must select a job to register.')
end

Then(/^I should see an correct message as "(.*?)"$/) do |mesg|
  expect(@app.candidate_site_login_page.message).to have_text(mesg)

end

When(/^I create account using existing user email and password$/) do
  @candidate = Candidate.new
  @candidate.email = CONFIG['EXTERNAL_CANDIDATE_EMAIL']
  @candidate.password = CONFIG['EXTERNAL_CANDIDATE_PASSWORD']

  #@app.candidate_create_account.load
  @app.candidate_site_login_page.create_account(@candidate)

end


Given(/^I create account with valid email and password$/) do
  @candidate = Candidate.new
  @candidate.email = "#{Random.rand(10000)}.#{Faker::Internet.safe_email}"
  print   @candidate.email
   
  @candidate.password = Faker::Internet.password(10,20)
  print  @candidate.password
  #@user = User.new
 # @user.initialize(@candidate.email,@candidate.password)

  #@app.candidate_create_account.load
  @app.candidate_site_login_page.create_account(@candidate)
end

Given(/^I create account with invalid email and valid passwords$/) do
  @candidate = Candidate.new
  @candidate.email = "Nota@Validemail"
  @candidate.password = Faker::Internet.password(10,20)
 # @app.candidate_create_account.load
  @app.candidate_site_login_page.create_account(@candidate)
end

Given(/^I create account with valid email and invalid passwords$/) do
  @candidate = Candidate.new
  @candidate.email = Faker::Internet.email
  @candidate.password = Faker::Internet.password(10,20)
  @candidate.confirm_password = Faker::Internet.password(5,15)
  #@app.candidate_create_account.load
  @app.candidate_site_login_page.create_account(@candidate)
end
