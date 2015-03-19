module CandidateSite
  class LoginPage < SitePrism::Page
    include Helpers
    set_url "/HRLogix.app"

    element :message, 'div.alert.alert-danger'
    element :username, '#uname'
    element :password, '#password'
    element :login_link, 'input.btn.btn-primary'
    element :forget_password_link, '#forgotten_pwd'
    element :create_account_link, '#create_acct'
    element :username_input, 'input#candidate\.uname_id'
    element :password_input, 'input#candidate\.password_id'
    element :confirm_password_input, "input[name='pword_conf'][type='password']"
    element :continue_button, 'input.btn.btn-primary'
    element :logout, :xpath, "//a[text()='Logout']"
    

    def login(candidate_username, candidate_password)
      username.set candidate_username unless username_disabled?
      password.set candidate_password
      login_link.click
    end

    def error_message
      message.text
    end

    def loggedin?
      has_no_username? && has_no_password?
    end

    def username_disabled?
      username.disabled?
    end
    def create_account(candidate)
      username_input.set candidate.email
      password_input.set candidate.password
      confirm_password_input.set candidate.confirm_password || candidate.password
	  continue_button.click
	  
     end
     def loggedout?
      has_no_logout?
     end
     def logout_action
        logout.click
     end
end
end