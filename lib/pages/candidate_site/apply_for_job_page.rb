require_all 'lib'

class AppyForCandidateJob < SitePrism::Page
	include Helpers

	set_url "/CreateAccount.app"
	
#personal Information
element :description, 'input#description'
element :continue1, 'a.btn.btn-primary'
element :first_name, 'input#candidate\.first_name_id'
element :last_name, 'input#candidate\.last_name_id'
element :address, 'input#candidate\.address1_id'
element :city, 'input#candidate\.city_id'
element :state, 'select#candidate\.state_id'
element :zip_code, "input[id='candidate.zip_id'][name='candidate.zip.0']"
element :continue, "input[name='Submit'][class='btn btn-primary']"
element :screen_out_mesg, :xpath, "//div[@class='container']/section//p"
element :job_level_screen_out_mesg , 'span.labelDef p'
#contact Information
element :email_address, 'input#candidate.email_id'

#general information

element :area_of_expertise, '#candidate\.expertise_id'
element :desired_salary_range, '#candidate\.compensation_id'
element :professional_description, 'input#candidate\.short_description_id'
element :candidate_start_month, "#candidate.date_available_id.0"
element :candidate_start_day, '#candidate.date_available_id.1'
element :candidate_start_year, '#candidate.date_available_id.2'
element :previous_work_exp, 'candidate.previous_emp_id'

#education History

element :button_add, "input[name='btnSubmit'][value='Add']"
element :school_name, 'input#education\.institution_id'
element :education_start_month, '#education.start_date_id.0'
element :education_start_day, '#education.start_date_id.1'
element :education_start_year, '#education.start_date_id.2'
element :education_end_month, '#education.end_date_id.0'
element :education_end_day, '#education.end_date_id.1'
element :education_end_year, '#education.end_date_id.2'
element :education_level, '#education\.level_attained_id'
element :education_completed, '#education\.completed_id'
element :continue_button, "input[name='submit'][class='btn btn-primary']"


#employment History
element :work_history_start_month, '#work_history.start_date_id.0'
element :work_history_start_day, '#work_history.start_date_id.1'
element :work_history_start_month, '#work_history.start_date_id.2'
element :work_history_end_month, '#work_history.end_date_id.0'
element :work_history_end_day, '#work_history.end_date_id.1'
element :work_history_end_month, '#work_history.end_date_id.2'
element :work_history_company_name, 'input#work_history\.company_id'
element :work_history_job_title, 'input#work_history\.title_id'
element :work_history_gap_link, "img[src='images/en_US/icons/gapMustEdit.gif']"
element :work_history_gap_explain, 'input#work_history\.gap_explain_id'
element :work_history_gap_explained_link, "img[src='images/en_US/icons/gapEdit.gif']"
element :continue_submit, "input[name='btnsubmit'][class='btn btn-primary']"

#professional refrences

element :refrence_name, 'input#prof_reference\.name_id'
element :refrence_email, 'input#prof_reference\.email_id'

#aggreement page
element :agree_checkbox, "input[name='candidate.agree']"  # chek for it from code pass
element :employment_agreement, "input[name='candidate.employment_agree']"
element :employee_signature, 'input#candidate\.signature_id'

#Background Check Information

element :candidate_ssn_id, "input[id='candidate.ssn_id'][name='candidate.ssn.0']"
element :confirm_candidate_ssn_id, "input[id='candidate.ssn_id'][name='candidate.ssn.3']"
element :dl_state, '#candidate\.dl_state_id'
element :dl_id, 'input#candidate\.dl_number_id'
element :candidate_dob_month, '#candidate\.dob_id\.0'
element :candidate_dob_day, '#candidate\.dob_id\.1'
element :candidate_dob_year, '#candidate\.dob_id\.2'
element :ethnicity, '#candidate\.ethnicity_id'
element :gender, '#candidate\.gender_id'
element :other_name, 'input#candidate\.other_name_id'
element :employee_signature2, 'input#candidate\.credit_signature_id'

#EEO information
element :disabled, "#candidate\.disabled_id"
element :veteran, "#candidate\.veteran_id"

# screening page
element :screening_submit_button, "button#screeningSubmit"

#summary application 
element :tellus_why_textarea, "textarea[class='labelDef'][name='QQQ:1869']"




def fill_apply_for_job_form
    options = {
	:description => "HR Expert",
	:decision => "Yes",
	#:fname => "sanq",
	:fname => Faker::Name.first_name,
	:lname => Faker::Name.last_name,
	:addr => "#516,gold street",
	:city => "arizona",
	:state => "AZ",
	:zipcode => "11111",
	:expertise => "Human Resources",
	:salary => "$25-30K",
	:proDescription => "Expert in Handling HR activities",
	:school_name => "Geaorge walls",
	:education_level => "Bachelors Degree",
	:completed => "Yes",
	:company => "QAProduction LTD",
	:job_title => "Sr. HR Manager",
	:work_history_explanation => "due to health issues",
	:refrence_name => "Mr hilton jor",
	:refrence_email => "jorhiton@test.com",
	:ethnicity => "Asian",
	:gender => "Male"
	}
	
	
	

	
	description.set options[:description]
	continue1.click
	select_radio("input[class='formText'][name='QQQ:1177']",options[:decision])
	select_radio("input[class='formText'][name='QQQ:1374']",options[:decision])
	select_radio("input[class='formText'][name='QQQ:1075']",options[:decision])
	continue.click
	
	self.wait_for_first_name
	
	first_name.set options[:fname]
	last_name.set options[:lname]
	address.set options[:addr]
	city.set options[:city]
	select(options[:state], :from=>"candidate.state_id")
	zip_code.set options[:zipcode]
	continue.click
	
	#self.wait_for_professional_description
	
    select(	options[:expertise], :from=>"candidate.expertise_id")
	select(	options[:salary], :from=>"candidate.compensation_id")
	professional_description.set options[:proDescription]
	select(	"05", :from=>"candidate.date_available_id.0")
	select(	"25", :from=>"candidate.date_available_id.1")
    select(	"2015", :from=>"candidate.date_available_id.2")
	continue.click
	
	#education History
	#self.wait_for_ADD
	button_add.click
	self.wait_for_school_name
	school_name.set options[:school_name]
    select(	"02", :from=>"education.start_date_id.0")
	select(	"25", :from=>"education.start_date_id.1")
    select(	"2008", :from=>"education.start_date_id.2")
	select(	"02", :from=>"education.end_date_id.0")
	select(	"25", :from=>"education.end_date_id.1")
    select(	"2010", :from=>"education.end_date_id.2")
    select(	options[:education_level], :from=>"education.level_attained_id")
    select(	options[:completed], :from=>"education.completed_id")
	continue_button.click
	self.wait_for_button_add
	continue.click
	
	#Employment History
	self.wait_for_button_add
	button_add.click
	self.wait_for_work_history_company_name
	#choose("input[type='checkbox']")
	#wait_for_ajax
	
	select(	"03", :from=>"work_history.start_date_id.0")
	select(	"25", :from=>"work_history.start_date_id.1")
    select(	"2010", :from=>"work_history.start_date_id.2")

	select(	"04", :from=>"work_history.end_date_id.0")
	select(	"25", :from=>"work_history.end_date_id.1")
    select(	"2015", :from=>"work_history.end_date_id.2")
	work_history_company_name.set options[:company]
	work_history_job_title.set options[:job_title]
	continue_submit.click
	self.wait_for_button_add
	continue.click
	#messgae if comes
	
	work_history_gap_link.click
	self.wait_for_work_history_gap_explain
	work_history_gap_explain.set options[:work_history_explanation]
	continue_button.click
	self.wait_for_work_history_gap_explained_link
	continue.click
	
	
	#professional refrences
	
	button_add.click
	self.wait_for_refrence_name
	refrence_name.set options[:refrence_name]
	refrence_email.set options[:refrence_email]
	continue_button.click
	continue.click
	
	#Application Certification, Agreement & Release
	
	choose_radio("input[name='candidate.agree']","t")
	choose_radio("input[name='candidate.employment_agree']","t")
	str1 = options[:fname].concat(options[:lname])
	puts str1
	employee_signature.set str1
	continue.click
	
	#Background Check Information
	choose_radio("input[name='candidate.send_report']","t")
	choose_radio("input[name='candidate.send_report2']","t")
	candidate_ssn_id.set "111111111"
	confirm_candidate_ssn_id.set "111111111" 
	select("AZ", :from=>"candidate.dl_state_id")
	dl_id.set "145678"
	select(	"02", :from=>"candidate.dob_id.0")
	select(	"25", :from=>"candidate.dob_id.1")
    select(	"1989", :from=>"candidate.dob_id.2")
	#select etnicity
	select(	options[:ethnicity], :from=>"candidate.ethnicity_id")
	#select gender
	select(options[:gender], :from=>"candidate.gender_id")
	#enter other form name
	other_name.set options[:fname]
	
	choose_radio("input[name='candidate.credit_agree']","t")
	#puts options[:fname].concat(options[:lname])
	employee_signature2.set str1
	
	continue.click
	
	#EEO Information
	#self.wait_for_disabled
	continue.click
	#additional attachements if needed
	description.set options[:description]
	continue.click
	#eneter screening
	select_radio("input[class='formText'][name='QQQ:18']", "Yes")
	select_radio("input[class='formText'][name='QQQ:28']", "Yes")
	select_radio("input[class='formText'][name='QQQ:38']", "Yes")
	select_radio("input[class='formText'][name='QQQ:55']", "Yes")
	select_radio("input[class='formText'][name='QQQ:61']", "Yes")
	select_radio("input[class='formText'][name='QQQ:70']", "Yes")
	select_radio("input[class='formText'][name='QQQ:89']", "Yes")
	screening_submit_button.click
	
	continue1.click
	
	end
	
	
def fill_summary_application_details
    options = {
	:description => "QA test expert",
	:decision => "Yes",
	:fname => "rojaaa",
	:lname => "jan",
	:addr => "#516,gold street",
	:city => "arizona",
	:state => "AZ",
	:zipcode => "11134",
	}
     description.set options[:description]
	continue1.click
	select_radio("input[class='formText'][name='QQQ:1177']",options[:decision])
	select_radio("input[class='formText'][name='QQQ:1374']",options[:decision])
	select_radio("input[class='formText'][name='QQQ:1075']",options[:decision])
	continue.click
	
	self.wait_for_first_name
	
	first_name.set options[:fname]
	last_name.set options[:lname]
	address.set options[:addr]
	city.set options[:city]
	select(options[:state], :from=>"candidate.state_id")
	zip_code.set options[:zipcode]
	continue.click
	


    select_radio("input[class='formText'][name='QQQ:1237']", "Yes")
    choose_range("input[class='formText'][name='QQQ:1863']","2-3")
    select_radio("input[class='formText'][name='QQQ:1239']", "Yes")
    tellus_why_textarea.set "i have required experience"
    screening_submit_button.click
    continue1.click
end	
	
def fill_screen_out_application_details(screenoutlevel)
    options = {
	:description => "QA test expert",
	:fname => "rojaaa",
	:lname => "jan",
	:addr => "#516,gold street",
	:city => "arizona",
	:state => "AZ",
	:zipcode => "11134",
	}
    description.set options[:description]
	continue1.click
	
	if screenoutlevel == 'screening level'

    fill_screening_questsion("No")
	continue.click
    else
    fill_screening_questsion("Yes")
    continue.click
    first_name.set options[:fname]
	last_name.set options[:lname]
	address.set options[:addr]
	city.set options[:city]
	select(options[:state], :from=>"candidate.state_id")
	zip_code.set options[:zipcode]
	continue.click
	fill_job_level_summary_questions("No")
    screening_submit_button.click 
    end
end

def fill_screening_questsion(decision)
	select_radio("input[class='formText'][name='QQQ:1177']","#{decision}")
	select_radio("input[class='formText'][name='QQQ:1374']","#{decision}")
	select_radio("input[class='formText'][name='QQQ:1075']","#{decision}")
	
end
   
def fill_job_level_summary_questions(decision)
	select_radio("input[class='formText'][name='QQQ:1237']", "#{decision}")
    choose_range("input[class='formText'][name='QQQ:1863']","0-1")
    select_radio("input[class='formText'][name='QQQ:1239']", "#{decision}")
    tellus_why_textarea.set "i have required experience"
end
    

def select_radio(selector, value)
    if value == "Yes" then find("#{selector}[value='Yes']").click
    else find("#{selector}[value='No']").click
    end
  end


def choose_radio(selector, value)
    if value == "t" then find("#{selector}[value='t']").click
    else find("#{selector}[value='f']").click
    end
  end



def choose_range(selector, value1)
    find("#{selector}[value='#{value1}']").click
    
   
  end
#def display_message(locator)
 end
 
















