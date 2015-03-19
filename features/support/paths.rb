module NavigationHelpers
  def path_to(page_name)
    case page_name
      #EXTERNAL CANDIDATE SITE PAGES
      when /^external home page$/
        '/candidate/search.html#!/search'
      when /^external search results$/
        '/candidate/search.html#!/results/internal%3B%3B%3B%3B'
      when /^external jd$/
        '/candidate/search.html#!/job/213-28074'
      when /^external apply contact info$/
        '/candidate/apply.html#!/job/28074/contactinfo'
      when /^external login$/
        '/candidate/search.html#!/login'
      when /^external create$/
        '/candidate/search.html#!/create'

      #INTERNAL CANDIDATE SITE PAGES
      when /^internal home page$/
        "/candidate/#{CONFIG['CLIENT']}emps.html#!/search"
      when /^internal search results$/
        "/candidate/#{CONFIG['CLIENT']}emps.html#!/results/internal%3B%3B%3B%3B"
      when /^internal jd both job$/
        "/candidate/#{CONFIG['CLIENT']}emps.html#!/job/213-28076"
      when /^internal jd internal job$/
        "/candidate/#{CONFIG['CLIENT']}emps.html#!/job/213-28075"
      when /^internal apply contact info$/
        '/candidate/apply.html#!/job/28075/contactinfo'
      when /^internal both apply contact info$/
        '/candidate/apply.html#!/job/28076/contactinfo'
      when /^internal create$/
        "/candidate/#{CONFIG['CLIENT']}emps.html#!/create"


      #RECRUITER SITE PAGES
      when /^recruiter home$/         #Need to rename to recruiter login
        '/Login.ats'
      when /^recruiter home page$/
        '/Home.jsp?op=reset'
      when /^create jobs$/
        '/TemplateRequisition.jsp?op=reset'
      when /^manage jobs$/
        '/ManageJobs.jsp?op=reset'
      when /^question groups$/
        '/QuestionManager.jsp?op=reset'
      when /^assessments search$/
        '/AssessmentApplication.jsp?op=reset'
      when /^recruiter manage offer template$/
        '/OfferTemplateManager.jsp'
      when /^recruiter create offer template$/
        '/OfferTemplateDetail.jsp?'
      when /^recruiter manage offer approval process$/
        '/recruiter/#!/approval-workflows'
    end

  end

  def current_path_info
    current_url.sub(Capybara.app_host, '')[%r{[/\?\#].*}] || '/'
  end
end
World(NavigationHelpers)
