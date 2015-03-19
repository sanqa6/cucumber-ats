Given(/^I am on page "(.*?)"$/) do |page_name|
  visit path_to(page_name)
  #sleep 5
  current_path_info.should == path_to(page_name)
end

Then(/^"(.*?)" is displayed$/) do |expected_content|
  print expected_content
  page.should have_content(expected_content)
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field, :with => value)
end

When(/^I click button "(.*?)"$/) do |button|
  click_button(button)
end

Then(/^I should see "(.*?)"$/) do |text|
  page.should have_content(text)
end

Then(/^the page displayed is "(.*?)"$/) do |page_name|
  sleep 5
  current_path_info.should == path_to(page_name)
end

Then(/^the url starts with "(.*?)"$/) do |page_name|
  current_path_info.start_with?(path_to(page_name)).should be_truthy,
  "#{current_path_info} should start with #{path_to(page_name)}"
end

Then(/^the page displayed has title (.*?)$/) do |title|
    using_wait_time 10 do
    page.should have_content(title)
  end
end

Then(/^the page title should be (.*?)$/) do |title|
  page.find('h1.page-title').text title
end

When(/^I click link "(.*?)"$/) do |link|
  find_link(link).click
  sleep 2
end

Then(/^my job is displayed in the table$/) do
 page.should have_css('tr', text: @unique_job_title)
end

Then(/^my job is not displayed in the table$/) do
  page.should have_no_css('tr', text: @unique_job_title)
end

And(/^my job is displayed on header$/) do
 page.should have_css('h1', text: @unique_job_title)
end

Given(/^I click on my job in the table$/) do
  find('tr', :text => @unique_job_title).click
end

Then(/^the page displayed has no input fields$/) do
   #(page.has_content?('input.form-control', :match => :first )) == false
   page.should have_no_css('input[type="text"]')
 end

Then(/^the page displayed has input fields$/) do
   #(page.has_content?('input.form-control', :match => :first )) == true
   page.should have_css('input[type="text"]')
 end

When(/^I click on my job$/) do
  find('td', :text => @unique_job_title).click_link(@unique_job_title)
  #find('a', :text => @unique_job_title).click
end

Given(/^I start a new session$/) do
Capybara.current_session.driver.quit
@session = Capybara::Session.new(:selenium)
end

When(/^I click "(.*?)"$/) do |name|
click_link_or_button(name)
end


Given(/^PENDING (.*)/) do | reason|
  pending reason
end
