module CandidateSite
  class CreateAccountPage < SitePrism::Page
    include Helpers

    #set_url "/candidate/#!/create{?email*}"
    set_url "/findlyats/CreateAccount.app?op=jobcheck&errPage=AppJobSearch.jsp&nextPage=AppCreateAccount.jsp"

    #section :menu, CandidateMenuSection, "#login"
    section :form, ".login" do
      element :title, "h2"
      element :login_link, "#login_return"
      element :username_input, "#email"
      element :password_input, "#password"
      element :confirm_password_input, "input.pword_conf"
      element :continue_button, "input.btn.btn-primary"
     # element :submit_button, "#create_account"

      element :error_message, "#messages"
    end

    def fill_form(candidate)
      form.username_input.set candidate.email
      form.password_input.set candidate.password
      form.confirm_password_input.set candidate.confirm_password || candidate.password
    end

    def create_account!(candidate)
      fill_form(candidate)
      submit_form
    end

    def submit_form
      form.continue_button.click
    end

    def error_message_content
      form.error_message.text
    end

    def redirect_to_login
      form.login_link.click
    end

    #Cannot verify the page using url, checking the
    def current_page?
        form.has_submit_button?
    end

  end
end
