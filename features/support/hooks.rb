Before do
  window = Capybara.current_session.driver.browser.manage.window
  window.maximize
  @app = Ats::Pages.new
  @context = Ats::Context.new
end

Before do |scenario|
  scenario.source_tag_names.each do |tag|
    driver_name = tag.sub(/^@/, '').to_sym
    if Capybara.drivers.has_key?(driver_name)
      Capybara.current_driver = driver_name
    end
  end
end

# Before ('@pollinator') do
  # @session = Capybara::Session.new(:selenium)
# end

# After ('@pollinator') do

  # Capybara.current_session.driver.quit
# end

# Before ('@recruiterlogin') do
  # visit '/Setup.ats'
  # fill_in('uname', :with => CONFIG["ADMIN"])
  # fill_in('password', :with => CONFIG["ADMIN_PASSWORD"])
  # find('a.login').click
  # page.should have_content('Sign Out')
# end

# After ('@createjob') do |scenario|
  # if scenario.failed?
    # visit '/Setup.ats'
    # fill_in('uname', :with => CONFIG["ADMIN"])
    # fill_in('password', :with => CONFIG["ADMIN_PASSWORD"])
    # find('a.login').click
    # page.should have_content('Sign Out')

    # visit path_to('manage jobs')
    # find('a', :text => 'Filter Jobs').click
    # fill_in('requisition.title', :with => @unique_job_title)
    # click_button('Search')
    # find('tr', text: @unique_job_title).click_link('Open')
    # select "Closed", :from => "req_status.status"
    # click_button('change')
    # puts "{#{@unique_job_title} was closed after the scenario failed"
  # else
    # puts "{#{@unique_job_title} was closed during the scenario"
  # end
# end

at_exit do
 # @test_context = nil #clear any test context stored in hash
end
