module ExternalSite
  class LoginPage < CandidateSite::LoginPage
    set_url_matcher /candidate\/.*login/

  end
end