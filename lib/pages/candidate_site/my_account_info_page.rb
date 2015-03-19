require_all 'lib'

class MyAccountInfoPage < SitePrism::Page
	include Helpers

	set_url "/AppMyAccountInfo.jsp"
	
	
	#Apply history
	element :applied_job_title, "table#xs-table tr td[data-title='Job Title'] a"
	element :job_code, "table#xs-table tr td[data-title='Job Code'] span"
	element :status, "table#xs-table tr td[data-title='Status'] span"
	element :date_applied, "table#xs-table tr td[data-title='Date Applied']>span>span"
	
	
	end
	
	
	