require_all 'lib'

class CandidateCompositeJobSearchResults < SitePrism::Page
  include Helpers
  #   include WaitForAjax

  set_url "/CompositeSearch.app"

  # Menu
 # section :menu, RecruiterMenu, "nav[class='header-nav pull-right clearfix']"

  #Table
  element :search_jobs_result_table, "#xs-table"
  element :job_title, :xpath, "//table[@id='xs-table']/tbody/tr[2]/td[3]/a"
  element :apply_for_job, "input[class='btn btn-primary'][type='submit']"

  def open_Job
    job_title.click
    wait_for_apply_for_job
  end
  
  def apply_for_this_job
      apply_for_job.click
  end
      
  def getcount_of_SearchedJob_results
       count=page.all('#xs-table tbody tr').count
       puts count
       count=count-1

   end    

   def searched_jobs_results
     page.all('#xs-table tbody tr').map do |tr|
       {
         type: tr.all('td')[0].text,
         first_name: tr.all('td')[1].text,
         last_name: tr.all('td')[2].text,
         city: tr.all('td')[3].text,
         state: tr.all('td')[4].text,
         phone: tr.all('td')[5].text,
         referral_source: tr.all('td')[6].text
       }
     end
   end
end