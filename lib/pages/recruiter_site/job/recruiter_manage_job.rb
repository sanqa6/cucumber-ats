require_all 'lib'

class RecruiterManageJobs < SitePrism::Page
  include Helpers
  set_url "/ManageJobs.jsp?op=reset"

  section :menu, RecruiterMenu, "nav[class='header-nav pull-right clearfix']"

  element :search, "#SearchComposite_ID"
  element :job_list, "#req-view-table"

	#In Manage Job, Search for a Job Title and return Status text value
	#job: Job Title
	def search_find_job_and_get_status(job)
	    click_on('Filter Jobs')
	    wait_for_ajax
	    fill_in('users-id-search', :with => "") #clear Recruiter field
	    fill_in('requisition.title_id', :with => "#{job}")
	    click_on('search-btn-id')
	    wait_for_ajax
	    search_job_get_status(job)
	end

	#Find job in Manage Jobs table and return the Status value
	def search_job_get_status(searchString)
    search_and_get_value_table('requisition-view-table-body',4, searchString, 10)
  end

  def job_list_columns
    job_list.all('thead tr th').map do |head|
      head.text
    end
  end

  def search_filters
    click_on('Filter Jobs')
    search.all('label').map do |box|
      box.text
    end
  end
end
