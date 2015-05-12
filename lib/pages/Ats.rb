#instantiate ATS class once to create all page objects.
module Ats

  class Pages
  
    def composite_search_page
	    CandidateCompositeJobSearchResults.new
	  end	
    def candidate_job_search
	    SearchJobsPage.new
	  end	


    def candidate_home_page
      CandidateSite::CandidateHomePage.new
    end  

    def apply_for_job_page
        AppyForCandidateJob.new
    end
    
    def my_account_info_page
        MyAccountInfoPage.new
    end
            

    def recruiter_login
      RecruiterLogin.new
    end

    def recruiter_home
      RecruiterHome.new
    end

    def recruiterCreateJob
      RecruiterCreateJob.new
    end

    def recruiter_manage_jobs
      RecruiterManageJobs.new
    end

    def recruiterCompositeSearch
      RecruiterCompositeSearch.new
    end

    def recruiter_draft_jobs
      RecruiterDraftJobs.new
    end

    def recruiter_approve_jobs
      RecruiterApproveJobs.new
    end
	# my def
	def recruiter_change_password
	   RecruiterPasswordChangePage.new
	end   

    def candidate_profile_applicant_type
      CandidateProfile::ChangeApplicantTypePage.new
    end

    #def candidate_create_account
    #  CandidateSite::CreateAccountPage.new
    #end

    def recruiter_offer_template_list
      RecruiterSite::OfferTemplateListPage.new
    end

    def recruiter_offer_template_create
      RecruiterSite::OfferTemplateCreatePage.new
    end


    def forgot_password_page
        CandidateForgotPasswordPage.new
    end
        
    def candidate_site_login_page
      CandidateSite::LoginPage.new
    end

    def external_site_login_page
      #ExternalSite::LoginPage.new
    end

    def external_site_home_page
      ExternalSite::HomePage.new
    end

    def internal_site_login_page
      InternalSite::LoginPage.new
    end

    def internal_site_home_page
      InternalSite::HomePage.new
    end
  	def recruiter_offer_template_create
  		RecruiterSite::OfferTemplateCreatePage.new
  	end

  	def recruiter_offer_approval_process
  		RecruiterSite::OfferApprovalProcessPage.new
  	end

  	def recruiter_offer_approval_process_create
  		RecruiterSite::OfferApprovalProcessCreatePage.new
  	end
  end
end
