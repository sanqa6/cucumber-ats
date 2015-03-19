require_all 'lib'

class RecruiterCompositeSearch < SitePrism::Page
  include Helpers
  #   include WaitForAjax

  set_url "/CompositeSearch.ats"

  # Menu
  section :menu, RecruiterMenu, "nav[class='header-nav pull-right clearfix']"

  #Table
  element :candidate_table, "#candidate-view-table"

  def candidates
    page.all('#candidate-view-table tbody tr').map do |tr|
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
