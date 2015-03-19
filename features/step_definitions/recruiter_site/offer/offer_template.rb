
Given(/^I have an offer template$/) do
  manage_offer_template_page = "recruiter manage offer template"
  create_offer_page_title = "Create New Offer Template"

  @offer_template = {
    title: "#{Faker::Name.title}-#{Random.rand(100000)}"
  }
  step "I am on page \"#{manage_offer_template_page}\""
  step "I click the create button"
  step "the page title should be \"#{create_offer_page_title}\""
  step "I fill offer template fields"
  @app.recruiter_offer_template_create.select_first_offer_letter
  step "I submit the Offer Template"
  step "the url starts with \"#{manage_offer_template_page}\""
end

And(/^I fill offer template fields$/) do
  step "I set the offer template name"
  step "I click the next button"
  step "I add a Text Box"
  step "I add a Text Area"
  step "I add a Drop Down"
  step "I add a Vertical Radio"
  step "I add a Date Picker"
  step "I click the next button"
end

When(/^I search for this offer template$/) do
  @app.recruiter_offer_template_list.search(@offer_template[:title])
end

Then(/^this offer template should exist$/) do
  expect(@app.recruiter_offer_template_list.template_is_present?(@offer_template[:title])).to be_truthy
end

Then(/^this offer template should not exist$/) do
  expect(@app.recruiter_offer_template_list.template_is_present?(@offer_template[:title])).to be_falsey
end

And(/^I edit the offer template$/) do
  expect(@app.recruiter_offer_template_list.edit(@offer_template[:title])).not_to be_nil
  wait_for_ajax
  @offer_template[:title] = "#{Faker::Name.title}-#{Random.rand(100000)}"
  @app.recruiter_offer_template_create.setName(@offer_template[:title])
  @app.recruiter_offer_template_create.submit_offer_template
end

Then(/^I clone this offer template$/) do
  expect(@app.recruiter_offer_template_list.clone(@offer_template[:title])).not_to be_nil
  sleep 5
  @app.recruiter_offer_template_create.submit_offer_template
end

Then(/^I delete this offer template$/) do
  expect(@app.recruiter_offer_template_list.delete(@offer_template[:title])).not_to be_nil
end

And(/^I click the create button$/) do
  @app.recruiter_offer_template_list.click_create_button
end

And(/^I click the next button$/) do
  @app.recruiter_offer_template_create.next
end

And(/^I set the offer template name$/) do
  @app.recruiter_offer_template_create.setName(@offer_template[:title])
end

And(/^I add a Text Area$/) do
  @app.recruiter_offer_template_create.add_field('Comment', 'Text Area', {
    required: 'Yes',
    rows: 4
    })
end

And(/^I add a Text Box$/) do
  @app.recruiter_offer_template_create.add_field('Job', 'Text Box', {
    required: 'No'
    })
end

And(/^I add a Vertical Radio$/) do
  @app.recruiter_offer_template_create.add_field('Option ?', 'Vertical Radio', {
    required: 'Yes',
    options: [
      { label: 'Option 1', value: 1 },
      { label: 'Option 2', value: 2 },
      { label: 'Option 3', value: 3 }
    ]
    })
end

And(/^I add a Drop Down$/) do
  @app.recruiter_offer_template_create.add_field('Select ?', 'Drop Down', {
    required: 'Yes',
    options: [
      { label: 'select 1', value: 1 },
      { label: 'select 2', value: 2 },
      { label: 'select 3', value: 3 }
    ]
    })
end

And(/^I add a Date Picker$/) do
  @app.recruiter_offer_template_create.add_field('Start Date', 'Date Picker', {
    required: 'No'
    })
end

And(/^I create an Offer Letter Template$/) do
  @app.recruiter_offer_template_create.create_offer_letter
end

Then(/^I submit the Offer Template$/) do
  @app.recruiter_offer_template_create.submit_offer_template
end
