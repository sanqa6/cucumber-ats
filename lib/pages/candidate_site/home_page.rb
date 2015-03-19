module CandidateSite
	class CandidateHomePage < SitePrism::Page
		include Helpers
    set_url "/Setup.app"

#section:navigation, "div#navbarCollapse" do

element:job_search_link, :xpath,"//div[@id='navbarCollapse']/ul[@class='nav navbar-nav']/li[1]/a"
element:help_link, :xpath, "//div[@id='navbarCollapse']/ul[@class='nav navbar-nav']/li[2]/a"
element:login_link, :xpath, "//div[@id='navbarCollapse']/ul[@class='nav navbar-nav navbar-right']/li/a"
#end
 

 def goTo_LoginPage

     login_link.click
 end
 
 def goTo_JobSearchPage

     job_search_link.click
 end

end
end