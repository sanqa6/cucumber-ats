

When(/^I search for "(.*?)"$/) do |search_term|
  fill_in 'keywords', with: search_term
end

When(/^I complete the pollinator manually using "(.*?)"$/) do |email|
manual_complete_pollinator email
end

When(/^I enter password "(.*?)" and click login$/) do |password|
      fill_in('password', :with => password)
      find('#login_btn').click
end


Then(/^person icon is available$/) do
  find('.glyphicon-user').click
  page.has_content?('My Activity')
end



When(/^I click on my job in the search results page$/) do
  find('tr', text: @unique_job_title).visible?
  find('tr', text: @unique_job_title).click
end


When(/^I search for my job on the "(.*?)"$/) do |page_name|
  visit path_to(page_name)
  sleep 5
  fill_in('keywords', with: '"' + @unique_job_title + '"')
  click_button('Search')
end

Then(/^I should find that job on the external site$/) do
  step "I search for my job on the \"external home page\""
  step "that job should be displayed"
end

Then(/^I should find that job on the internal site$/) do
  step "I search for my job on the \"external home page\""
  step "that job should be displayed"
end

Then(/^I should not find that job on the external site$/) do
  step "I search for my job on the \"external home page\""
  step "that job should not be displayed"
end

Then(/^I should not find that job on the internal site$/) do
  step "I search for my job on the \"external home page\""
  step "that job should not be displayed"
end

Then(/^I should find that job on both sites$/) do
  step "I should find that job on the external site"
  step "I should find that job on the internal site"
end

Then(/^I should not find that job on both sites$/) do
  step "I should not find that job on the external site"
  step "I should not find that job on the internal site"
end

Given(/^I log out of the candidate site$/) do
  @app.candidate_site.logout
end

Given(/^I login to the external site with email "(.*?)" and password "(.*?)"$/) do |username, password|
  login_candidate_external_site(username, password)
end

Given(/^I apply for my job$/) do
  job_title = @unique_job_title
  apply_for_job(job_title)
end
