require_all 'lib'

class RecruiterDraftJobs < SitePrism::Page
  include Helpers
  set_url "/RecruiterRequisition.jsp?op=reset"

  element :page_title, "h1.page-title"
  element :job_list, "#recruiter-req-table"

  def job_list_columns
    job_list.all('thead tr th').map do |head|
      head.text
    end
  end
end
