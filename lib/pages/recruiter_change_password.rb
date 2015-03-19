require_all 'lib'

class RecruiterPasswordChangePage < SitePrism::Page
  include Helpers
  set_url "/ChangePassword.jsp"

  element :current_password_field, "#opw"
  element :new_password_field, "input[id='users.password'][type='password']"
  element :confirm_password_field, "#cpw"
  element :change_button, "#submit-new-task"
  element :page_title, "div.section-header>h2"
  element :alert_box, "div#alert-box.alert.alert-danger"
  #perform the action of changing current login password of a user to new login password
  def recruiter_password_change(current_password,new_password)
      current_password_field.set current_password
	  new_password_field.set new_password
      confirm_password_field.set new_password
	  change_button.click
	  
  end
  
end