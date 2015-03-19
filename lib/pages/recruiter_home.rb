class RecruiterHome < SitePrism::Page
    set_url "/Login.ats"

    element :change_password_link, "a[href='ChangePassword.jsp']"
    element :signout_link, ".js-logout-action"

    # Menu
    section :menu, RecruiterMenu, "nav[class='header-nav pull-right clearfix']"

    # Submenu
    section :submenu, SubMenuItems, "nav[class='header-nav pull-right clearfix']"
    # My Dashboard


    section :dashboard, RecruiterDashboard, "#dashBoard"

    # Recently Viewed
    # TODO

    # Search People
    element :recruiter_search_first_name, "#candidate.first_name"
    element :recruiter_search_last_name, "#candidate.last_name"
    element :recruiter_search_email, "#candidate.email"
    element :recruiter_search_phone, "#candidate.phone1"
    element :recruiter_search_button, "#search-btn-id"

    def search_people_by_name(first_name,last_name)
      fill_in('First Name', :with => first_name)
      fill_in('Last Name', :with => last_name)
      click_button('Search')
    end
	
	#recruiter logout action
	def recruiter_logout()
	      signout_link.click
	end	  
end
