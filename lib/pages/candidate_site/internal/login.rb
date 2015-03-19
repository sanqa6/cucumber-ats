module InternalSite
  class LoginPage < CandidateSite::LoginPage
    include InternalPage

    set_url '/candidate{/client}emps.html#!/login'

  end
end