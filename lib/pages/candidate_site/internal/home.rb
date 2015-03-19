module InternalSite
  class HomePage < CandidateSite::HomePage
    include InternalPage

    set_url '/candidate{/client}emps.html#!/search'

    set_url_matcher /candidate\/.*emps.html.*search/

  end
end