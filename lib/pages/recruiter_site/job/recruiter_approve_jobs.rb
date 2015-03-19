require_all 'lib'

class RecruiterApproveJobs < SitePrism::Page
  include Helpers
  set_url "/ReqApprovalList.jsp?op=reset"

  element :page_title, "h1.page-title"
  element :search_handle, "#SearchComposite_ID a"
  element :job_list, "#req-approval-table"

  def job_list_columns
    job_list.all('thead tr th').map do |head|
      head.text
    end
  end
end
