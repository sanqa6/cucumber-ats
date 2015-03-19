
And(/^I perform forgot password action using existing email "(.*?)"$/) do |email|
	@app.candidate_site_login_page.forget_password_link.click
	@app.forgot_password_page.submit_forgot_password(email)

	
end

And(/^I perform forgot password action using nonexisting email "(.*?)"$/) do |email1|

    step "I perform forgot password action using existing email \"#{email1}\""

end
