module CandidateProfile
  class ChangeApplicantTypePage < SitePrism::Page
    include Helpers

    # Menu
    section :menu, RecruiterMenu, "nav[class='header-nav pull-right clearfix']"

    #Current App Type label
    element :current_type_label, ".labelDef"

    #Update button
    element :update_button, "#update-type"

    # method with '!' will do submit
    def update_type!(applicant_type)
      update_type applicant_type
      update_button.click
    end

    def update_type(applicant_type)
      select applicant_type, :from=> "candidate.access_type"
    end
  end
end
