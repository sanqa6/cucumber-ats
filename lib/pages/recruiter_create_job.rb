require_all 'lib'

class RecruiterCreateJob < SitePrism::Page
    include Helpers
 #   include WaitForAjax

    set_url "/TemplateRequisition.jsp?op=reset"

    # Menu
    section :menu, RecruiterMenu, "nav[class='header-nav pull-right clearfix']"

    #Table
    element :template_table, "#req-template-view-table"
    element :manage_job_table, "#req-view-table"

    #Elements
    element :templateSearch_field, '#requisition\.title'
    element :search_button, "#search-req"
    element :add_button, "#add-req"
    element :req_table, :xpath, ".//*[@id='req-template-view-table-body']"
    element :next_button, ".btn.btn-block.btn-default.next"
    element :save_draft_button, "input[value='Save Draft']"
    element :post_job_button, "input[value='Post Job']"

    #Basic Info
    element :template, ".radio-button #template"
    element :job_title, "#title"
    element :position_type, "select[name='jobType']"
    element :number_of_position, "#openings"
    element :job_description, "#cke_externalDesc"
    element :job_requirement, "#cke_requirements"

    #Job Details
    element :zip_code, "#jobZip"
    element :offer_template, "select[name='offerTemplateId']"

    #Access
    element :organizational_unit, ".nested-select-level>ul>li"

    #Posting
    element :post_type, "select[name='postType']"
    element :select_application_flow, "select[name='applicationFlowId']"
    element :category, "select[name='category']"

    #Screening
    element :job_screening_questions, ".bootstrap-tagsinput" #this is for cert
    element :screened_in_message, "#cke_screenInMsg"
    element :screened_out_message, "#cke_screenOutMsg"

    #Fills in text to CKEditor body
    # locator: id value Example: "externalDesc" not css "#externalDesc" (Example element: <textarea id="externalDesc" class="ckeditor" name="externalDesc" style="visibility: hidden; display: none;"/>)
    # opts: Text to enter
  def fill_in_ckeditor(locator, opts)
    content = opts.to_json #opts.fetch(:with).to_json
    page.execute_script <<-SCRIPT
      CKEDITOR.instances['#{locator}'].setData(#{content});
      $('textarea##{locator}').text(#{content});
    SCRIPT
  end

  # Select Radio Button
  # selector: css selector
  # value: bool ( t or f )
  def select_radio(selector, value)
    if value == "Yes" then find("#{selector}[value='t']").click
    else find("#{selector}[value='f']").click
    end
  end

  # Find and click on a Organizational Unit
  def select_organizational_unit(item)
    find(:xpath, ".//*[@id='hierarchyId_ui']/div/ul/li/a[starts-with(text(), '#{item}')]").click
  end

  # Select and choose a value from a typeahead element
  # label: Label of the typehead field
  # value: the exact value to be selected
  def select_typeahead(label, value)
    page.find('.select2-choices', :text=>"#{label}").click
    wait_for_ajax
    page.find('.select2-result-label', :text=>"#{value}").click
  end

  #Fill in Job form
  def fill_in_job_form(options={})
    options = {
      :template => "No",
      :job_title => "AT Job Title "+Time.now.strftime("%d-%m-%Y %H:%M:%S"),
      :position_type => "Full-Time",
      :number_of_position => "1",
      :job_description => "AT Job Description",
      :job_requirement => "AT Job Requirement",
      :zip_code => "60011",
      :offer_template => "Test Offer",
      :organizational_unit => "Alpine",
      :post_type => "Both",
      :select_application_flow => "QA Custom Questions",
      :category => "Entertainment",
      :job_screening_questions => "Interview Questionnaire 2",
      :screened_in_message => "AT: Congratulations you have been screened in.",
      :screened_out_message => "AT: Sorry, you have been screened out.",
      :default_application_status => "Applied"}.merge(options)

    # Basic Info
    select_radio(".radio-button #template", options[:template])
    #unique_job_title = (options[:job_title])+" "+Time.now.strftime("%d-%m-%Y %H:%M:%S")
    job_title.set options[:job_title]
    select(options[:position_type], :from=>"jobType")
    #position_type.select(options[:position_type])
    fill_in_ckeditor("externalDesc", options[:job_description])
    fill_in_ckeditor("requirements", options[:job_requirement])
    number_of_position.set options[:number_of_position]
    next_button.click

    #Job Details
    zip_code.set options[:zip_code]
    #offer_template.select(options[:offer_template])
    select(options[:offer_template], :from=>"offerTemplateId")
    next_button.click

    #Access
    select_organizational_unit(options[:organizational_unit])
    next_button.click

    #Posting
    #post.select(options[:post_type])
    select(options[:post_type], :from=>"postType")
    #select_application_flow.select options[:select_application_flow]
    select(options[:select_application_flow], :from=>"applicationFlowId")
    #category.select(options[:category])
    select(options[:category], :from=>"category")
    next_button.click

    # Screening
    select_typeahead(options["job_screening_questions"], options[:job_screening_questions])
    fill_in_ckeditor("screenInMsg", options[:screened_in_message])
    fill_in_ckeditor("screenOutMsg", options[:screened_out_message])
    select(options[:default_application_status], :from=>"defaultApplicationStatus")

    if options[:template] == "No"
      post_job_button.click
      self.wait_for_manage_job_table
    else
      click_on("Save Template")
      self.wait_for_template_table
    end
    (options[:job_title])
  end

  #In Create Job, Search for a Job Template
  #job: Job Template
  def search_template(job)
      templateSearch_field.set job
      search_button.click
      wait_for_ajax
  end

  #Find job template in Template table and return the first row template name value
  def find_in_table_template_name(job)
    search_and_get_value_table('req-template-view-table-body',1,job,1)
  end

end
