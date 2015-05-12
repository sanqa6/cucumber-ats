require_all 'lib'

class MyAccountInfoPage < SitePrism::Page
include Helpers
  set_url "/AppMyAccountInfo.jsp"
  element :applied_job_title, "table#xs-table tr td[data-title='Job Title'] a"
  element :date_applied, "table#xs-table tr td[data-title='Date Applied']>span>span"
  element :edit_profile_link, "table#xs-table tr td[data-title='Profile'] a"
  element :job_code, "table#xs-table tr td[data-title='Job Code'] span"
  element :status, "table#xs-table tr td[data-title='Status'] span"
  element :address, 'input#candidate\.address1_id'
    element :city, 'input#candidate\.city_id'
    element :continue, "input[name='Submit'][class='btn btn-primary']"
    element :continue2, "input[name='btnsubmit'][class='btn btn-primary']"
    element :continue_edit, "a[href='AppMyAccountInfo.jsp'][class='btn btn-primary']"
    element :continue3, "input[name='submit'][class='btn btn-primary']"


    element :edit_education_history, :xpath, "//a[text()='Education History']"

    element :edit_employment_history, :xpath, "//a[text()='Employment History']"

    element :edit_general_employment, :xpath, "//a[text()='General Employment']"
    
    element :edit_education_history, :xpath, "//a[text()='Education History']"
    

    element :edit_personal_info, :xpath, "//a[text()='Personal Information']"

    element :email_address, 'input#candidate.email_id'
    element :first_name, 'input#candidate\.first_name_id'
    element :last_name, 'input#candidate\.last_name_id'
    element :work_history_company_name, 'input#work_history\.company_id'
    element :work_history_job_title, 'input#work_history\.title_id'
    element :work_history_edit_link, "img[src='images/en_US/icons/edit.gif']"
    element :professional_description, 'input#candidate\.short_description_id'
    element :school_name, 'input#education\.institution_id'



    def click_edit_profile
        wait_for_edit_profile_link

     edit_profile_link.click
    end

    def click_edit_education_history

        edit_education_history.click

    end 

    def click_edit_employment_history

        edit_employment_history.click
      end

    def click_edit_personal_Info

         edit_personal_info.click
    end

    def click_edit_general_employment
      edit_general_employment.click
    end


    def edit_personal_Information

      
    click_edit_personal_Info

    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    first_name.set fname
    last_name.set lname
    

    continue.click

     end



     def edit_general_employment_details
      
      #wait_for_edit_general_employment

       click_edit_general_employment

     select( "eCommerce", :from=>"candidate.expertise_id")
     select( "$30-35K", :from=>"candidate.compensation_id")
     professional_description.set "Expert in ecommerce business"

     continue.click

     end 


     def edit_employment_history_details
      click_edit_employment_history
      work_history_edit_link.click


      work_history_company_name.set Faker::Company.name

      work_history_job_title.set Faker::Name.title

      continue2.click
      continue.click

    end



def edit_education_history_details

  edit_education_history.click

  work_history_edit_link.click

  school_name.set Faker::Company.name

    select( "Doctorate", :from=>"education.level_attained_id")
    select( "No", :from=>"education.completed_id")
  continue3.click
      continue.click

 end
     
     def submit_edit_profile
        continue_edit.click
      end  
    
   def edit_candidate_profile
        
        click_edit_profile

        edit_personal_Information

        edit_general_employment_details
        
        edit_employment_history_details

        edit_education_history_details

        submit_edit_profile



    end





    end  





