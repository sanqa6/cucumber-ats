module CandidateSite
  class BasePage < SitePrism::Page
    include Helpers

    section :menu, CandidateMenuSection, '#menucontent'

    element :user_button, '.logged'

    def loggedin?
      wait_for_user_button
      has_user_button? && user_button.visible?
    end

    def loggedout?
      find('#menucontent a.loginaction')
      menu.wait_until_login_link_visible
      menu.has_login_link?
    end

    def login(email_address, password)
      menu.login_link.click
    end

    def logout
      find('button.logged').click
      find('.logout_button').click
    end

    def pollinator_popup?
      not find(:css, '[id^="easyXDM_default"]').nil?
    end

    def wait
      wait_for_menu
      wait_for_user_button
    end

  end
end