module Logins
  def login_recruiter_site (username, password)
    visit '/Setup.ats'
    with_retries do
      fill_in('uname', :with => username)
      fill_in('password', :with => password)
      find('a.login').click
      expect(find('.js-logout-action')).to have_content 'Sign Out'
    end
  end

  def login_candidate_external_site(email, password)
    Capybara.current_session.driver.quit
    @session = Capybara::Session.new(:selenium)
    visit path_to('external home page')
    click_link('Login')
    manual_complete_pollinator email
    fill_in('password', :with => password)
    find('#login_btn').click
    find('.glyphicon-user').click
    expect(page).to have_content 'My Activity'
  end

  def login_candidate_internal_site(email, password)
    Capybara.current_session.driver.quit
    @session = Capybara::Session.new(:selenium)
    visit path_to('internal home page')
    click_link('Login')
    manual_complete_pollinator email
    fill_in('password', :with => password)
    find('#login_btn').click
    find('.glyphicon-user').click
    expect(page).to have_content 'My Activity'
  end

end
World(Logins)