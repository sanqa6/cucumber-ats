Given /^I am in the (recruiter|internal candidate|external candidate) site$/ do |site|
	case site
		when "recruiter"
			@app.recruiterLogin.load
		when "internal candidate"
			visit ('/candidate/keeperbaseemps.html#!/search')
		when "external candidate"
			visit ('/candidate/')
	end
end

Given /^I login as a "(.*?)"$/ do |role|
@current_role = role
end

When /^I login with a valid "(.*?)" and "(.*?)"$/ do |uname, password|
	@app.recruiterLogin.login_to_recruiter(uname, password)
end

Then /^I should see the following "(.*?)"$/ do |menu_items|
	items = menu_items.split(',')
	menu_array = Array.new(items)
	case @current_role
		when "Admin"
			menu_array.each { |m_item| page.should have_xpath("//a[text()=#{m_item}]") }
		when "Recruiter"
			menu_array.each { |m_item| page.should have_xpath("//a[text()=#{m_item}]") }
			page.should have_no_xpath("//a[text()='admin ']")
		when "Hiring Manager" 
			menu_array.each { |m_item| page.should have_xpath("//a[text()=#{m_item}]") }
			page.should have_no_xpath("//a[text()='People ']")
			page.should have_no_xpath("//a[text()='admin ']")
	end
end
