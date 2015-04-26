require_all 'lib'

class MyAccountInfoPage < SitePrism::Page
	include Helpers

	set_url "/AppMyAccountInfo.jsp"
	
	
	#Apply history
	element :applied_job_title, "table#xs-table tr td[data-title='Job Title'] a"
	element :job_code, "table#xs-table tr td[data-title='Job Code'] span"
	element :status, "table#xs-table tr td[data-title='Status'] span"
	element :date_applied, "table#xs-table tr td[data-title='Date Applied']>span>span"
	element :edit, "table#xs-table tr td[data-title='Profile'] a"
    element :edit_personal_info, :xpath, "//a[text()='Personal Information']"
    element :edit_general_employment, :xpath, "//a[text()='General Employment']"
    element :edit_education_history, :xpath, "//a[text()='Education History']"
    element :edit_employment_history, :xpath, "//a[text()='Employment History']"
    element :continue, "a[href='AppMyAccountInfo.jsp']"
    

	end





	
	
	