module Change_job_status
	def close_job(title)
	  visit path_to('manage jobs')
	  find('a', :text => 'Filter Jobs').click
	  fill_in('requisition.title', :with => title)
	  click_button('Search')
	  find('tr', text: title).click_link('Open')
	  select "Closed", :from => "req_status.status"
	  click_button('change')
	end

def update_job_status_to(status, title)
	  visit path_to('manage jobs')
	  find('a', :text => 'Filter Jobs').click
	  fill_in('requisition.title', :with => title)
	  click_button('Search')
	  find('tr', text: title).click_link('Open')
	  select status, :from => "req_status.status"
	  click_button('change')
	end

end
World(Change_job_status)