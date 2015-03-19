
And(/^I select "([^"]*)" from Change Applicant Type dropdown$/) do |type_option|
  @app.candidate_profile_applicant_type.update_type! type_option
end

And(/^Search of user with first name "([^"]*)" last name "([^"]*)" should show  "([^"]*)" in the type column$/) do |first_name, last_name, applicant_type|
  @app.recruiterHome.search_people_by_name first_name,last_name
  expect(@app.recruiterCompositeSearch.candidates.size).to eq(1)
  expect(@app.recruiterCompositeSearch.candidates[0][:type]).to eq(applicant_type)
end