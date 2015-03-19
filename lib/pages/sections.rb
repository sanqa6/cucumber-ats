class RecruiterMenu < SitePrism::Section
	element :home, "#homemenu"
	element :jobs, "#jobsmenu"
	element :people, "#Peoplemenu"
	element :admin, "#adminmenu"

	def clickSubMenu(submenu)
		find(:xpath, ".//*[@id='jobssubmenu']/li[1]/a[text()='#{submenu}']").click
	end
end

class HomeSubMenu < SitePrism::Section
	element :home, :xpath, "//li/a[text()='home'"
end

class SubMenuItems < SitePrism::Section
	elements :sub, "ul[class='list-inline'][role='menu'] li ul li a"
end

class RecruiterDashboard < SitePrism::Section
	element :dashboard_total_new, :xpath, "//li[1]/a"  #Total New
	element :dashboard_need_approval, :xpath, "//li[2]/a" #Need Approval
	element :recruiter_dashboard_total_open, :xpath, "//li[3]/a"  #Total Open
    element :recruiter_dashboard_recommended, :xpath, "//li[4]/a"  #Recommended	
end
