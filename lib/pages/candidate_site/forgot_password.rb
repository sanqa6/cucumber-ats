require_all 'lib'

class CandidateForgotPasswordPage < SitePrism::Page
	include Helpers

	set_url "/AppForgot.jsp"

	element :email_address, "input[class='form-control formTextReq'][name='email']"
	element :email_submit, "input[value='Submit'][class='btn btn-primary']"
    

    def submit_forgot_password(email)
    	email_address.set email
    	email_submit.click
    end


end



