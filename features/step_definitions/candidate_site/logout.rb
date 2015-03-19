Then(/^I do logout of candidate site$/) do
    @app.candidate_site_login_page.logout_action

  expect(@app.candidate_site_login_page.loggedout?).to be true
end

Then(/^I should be logged out of candidate site$/) do
	expect(@app.candidate_site_login_page.loggedout?).to be true
end
	