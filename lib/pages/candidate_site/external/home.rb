module ExternalSite
  class HomePage < CandidateSite::HomePage
    set_url '/candidate/#!/search'

    set_url_matcher /candidate\/.*search/

  end
end