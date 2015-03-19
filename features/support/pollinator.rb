module Pollinator
	def manual_complete_pollinator(email)
		browser = Capybara.current_session.driver.browser
		using_wait_time 15 do
			
			within_frame find(:css, '[id^="easyXDM_default"]') do
				sleep 2
				within_frame 0 do
					find(:id, 'usemail').click
					page.should have_content('email')
					fill_in('email', :with => email)
					find('#manualjoinbutton').visible?
					sleep 2
					find('#manualjoinbutton').click
					page.driver.browser.switch_to.window page.driver.browser.window_handles.first
					

				end
			end
			
		end
		
  end

  def verify_and_register_pollinator(first_name, last_name,job_title,employer,address)
    browser = Capybara.current_session.driver.browser
    using_wait_time 15 do

      within_frame find(:css, '[id^="easyXDM_default"]') do
        sleep 2
        within_frame 0 do
          expect(page).to have_selector('#FirstName')
          expect(page).to have_selector('#LastName')
          expect(page).to have_selector('#JobTitle')
          expect(page).to have_selector('#Employer')
          expect(page).to have_selector('#Location')
          expect(page).to have_selector('#thanksbutton')
          fill_in('FirstName',:with=>first_name)
          fill_in('LastName',:with=>last_name)
          fill_in('JobTitle',:with=>job_title)
          fill_in('Employer',:with=>employer)
          find('#Location').native.send_keys(address)
          with_retries do
            find('#Location').click
            find('.pac-item',  match: :first).click
          end
          find('#thanksbutton').click
          page.driver.browser.switch_to.window page.driver.browser.window_handles.first
        end
      end

    end

  end


end	
World(Pollinator)