class RecruiterLogin < SitePrism::Page
  set_url "/Login.ats"

  element :username_field, "input[name='uname']"
  element :password_field, "input[name='password']"
  element :login_button, :xpath, "//a[text()='Log In']"
  element :forgot_password_link, ".forgot>a"
  element :remember_me_checkbox, "#check-1"
  element :login_error_message, ".error"

  element :findly_logo, '.logo.pull-left'

  # Logs in to recruiter site with given username and password.
  # It is not necessary to load recruiter login page before using this method.
  def login_to_recruiter(username, password)
  	self.load unless current_url == self.load
  	username_field.set username
  	password_field.set password
  	login_button.click
  end

end