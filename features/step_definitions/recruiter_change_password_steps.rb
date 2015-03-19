
When(/^I am on change password page$/) do
  @app.recruiter_change_password.load
  expect(@app.recruiter_change_password.page_title).to have_text('Change Account Information')
  end

And (/^I change my current login password with "(.*?)"$/) do|newpassword|
	print newpassword
    @app.recruiter_change_password.recruiter_password_change(CONFIG["ADMIN_PASSWORD"],newpassword)
	expect(@app.recruiter_change_password.alert_box).to have_text('Your information change request has been accepted, and applied.')
	@app.recruiter_home.recruiter_logout()
	
	end

Then(/^I should be able to login with new password "(.*?)"$/) do |newpassword|
    @app.recruiter_login.login_to_recruiter(CONFIG["ADMIN"],newpassword)
    expect(@app.recruiter_home.signout_link).to have_content 'Sign Out'
    @app.recruiter_home.recruiter_logout()
    end
	
And (/^I should not be able to login with old password$/) do
     @app.recruiter_login.login_to_recruiter(CONFIG["ADMIN"],CONFIG["ADMIN_PASSWORD"])
	 wait_for_ajax
	 expect(@app.recruiter_login.login_error_message).to have_content 'Your Username and Password combination is incorrect. Please try again.'
	 end
	
	

