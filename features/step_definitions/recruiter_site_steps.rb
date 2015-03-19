
Given(/^I am logged in as an admin user$/) do
  login_recruiter_site(CONFIG["ADMIN"], CONFIG["ADMIN_PASSWORD"])
end

Given(/^I am logged in as a hiring manager$/) do
  login_recruiter_site(CONFIG["HM"], CONFIG["HM_PASSWORD"])
end

When(/^I am logged in as a recruiter$/) do
  login_recruiter_site(CONFIG["RECRUITER"], CONFIG["RECRUITER_PASSWORD"])
end

When(/^I am logged in as a background check user$/) do
  login_recruiter_site(CONFIG["FIRST_ADVANTAGE"], CONFIG["FIRST_ADVANTAGE_PASSWORD"])
end

Given(/^I search for template "(.*?)"$/) do |template_name|
  fill_in('requisition.title', :with => template_name)
  click_button('Search')
end

Given(/^I use "(.*?)"$/) do |template_name|
    find('tr', :text => template_name).click_link('Use')
  	find_field('Job Title').visible?
end



When(/^I search for my job on the recruiter site$/) do
  visit path_to('manage jobs')
  find('a', :text => 'Filter Jobs').click
  fill_in('users-id-search', :with=>"")
  page.find('#users-id-search').native.send_keys(:backspace)
  fill_in('requisition.title', :with => @unique_job_title)
  click_button('Search')
end

When(/^I search for my job on the hm site$/) do
  #visit path_to('manage jobs hm')
  find('a', :text => 'Filter Requisition List').click
  fill_in('requisition.title', :with => @unique_job_title)
  click_button('Search')
end


Given(/^I fill in "(.*?)" with a unique title using date time$/) do |title|
  create_unique_title
  fill_in(title, :with => @unique_job_title)
end





When(/^I fill in the autocomplete "(.*?)" with "(.*?)"$/) do |label, value|
  page.find('.select2-choices', :text=>label).click
  #fill_in('s2id_autogen1', :with=> value)
  find('.select2-result-label', :text=>value).click
end

When(/^I select "(.*?)" from the ajax list$/) do |value|
  #sleep 5
  page.has_content?('value')
  page.first('p', :text => value).click
end

When(/^I select "(.*?)" from autocomplete "(.*?)"$/) do |value, label|
   page.find('.control-row', :text=> label).find('.tt-query').set(value)
  #sleep 5
  page.first('p', :text => value).click
end

Then(/^"(.*?)" is displayed as a tag$/) do |value|
 find('.select2-search-choice', :text=>value).visible?
 end

When(/^I search for my question group on the recruiter site$/) do
  fill_in('sqname', :with => @unique_qg_name )
  click_button('Search')
end

Then(/^my question group is available on the recruiter site$/) do
  find('tr', text: @unique_qg_name).visible?
end

Given(/^I close my job$/) do
  close_job(@unique_job_title)
end

Given(/^I change the status of the job to "(.*?)"$/) do |status|
  update_job_status_to(status, @unique_job_title)
end

When(/^I change the status of that job to Closed$/) do
  step "I change the status of the job to \"Closed\""
end

When(/^I change the status of that job to Hold$/) do
  step "I change the status of the job to \"Hold\""
end

When(/^I change the status of that job to Cancelled$/) do
  step "I change the status of the job to \"Cancelled\""
end

Given(/^I click the first job title in the table$/) do
  within_table ('apply-history-table') do
     #find(page.all('tr')[1].first('a')).click
     #find('a')[2].click
     within (page.all('tr')[1]) do
      first('a', :visible => false).click
  end
 end
end

When(/^I click on "(.*?)" menu and select "(.*?)"$/) do |menuname, menuitem|
  within ('.header-nav') do
    find('li', :text => menuname).click
    within ('.dropdown-menu') do
       find('li', :text => menuitem).click
     end
  end

end

Then(/^there is a table row containing "(.*?)", "(.*?)" and "(.*?)"$/) do |item1, item2, item3|
  find('tr', :text => item1, :text => item2).should have_content(item3)
end


When(/^I navigate to the candidate profile for user first name "(.*?)" last name "(.*?)"$/) do |firstname, lastname|
  fill_in('First Name', :with => firstname)
  fill_in('Last Name', :with => lastname)
  click_button('Search')
  click_link(firstname)
end


When(/^I select "(.*?)" from the actions dropdown$/) do |action|
  select(action, :from=>'candidateaction')
  click_link_or_button('Submit')
end

When(/^I search for my job on add to job$/) do
  click_link('Filter Jobs')
  fill_in('Job Title', :with=>@unique_job_title)
  click_link('Search')
end

When(/^I select my job$/) do
  find('tr', :text=> @unique_job_title).find("input[type='checkbox']").click
end

Then(/^there is a table row containing my job with status "(.*?)" and step "(.*?)"$/) do |status, step|
  within('#apply-history-table') do
    find('tr', text: @unique_job_title).find("span.status.active[title=#{status}]")
    find('tr', text: @unique_job_title).find('a', text: step)
  end
end


When(/^I click link for my job in the apply history table$/) do
  within('#apply-history-table') do
    find('tr', text: @unique_job_title).find('a', :text => @unique_job_title).click
  end
end

When(/^I click link to order a "(.*?)" package$/) do |package_name|
  using_wait_time 10 do
    page.should have_css('#packages-table')
  end
  within('#packages-table') do
    find('tr', text: package_name).find('button', :text => 'Order').click
  end
end

Then(/^there is an alert box containing the message "(.*?)"$/) do |expected_message|
  using_wait_time 10 do
    page.should have_css('#alert-box')
  end
  within('#alert-box') do
    find('span', text: expected_message)
  end
end
