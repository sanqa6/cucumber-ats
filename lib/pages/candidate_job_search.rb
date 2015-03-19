require_all 'lib'

class SearchJobsPage < SitePrism::Page
include Helpers

    set_url "/AppJobSearch.jsp"
	elements :category_search_list, "div#catsearch li a"
	
	element :category_search_link, "li.active a"
	element :custom_search_link, :xpath,"//a[text()='Custom Search']"
    element :job_search_link, :xpath,"//a[text()='Job Search']"

	section :form, "form[name='SearchComposite']" do
	elements :category_list, "select#requisition.category_id option"
	elements :location_list, "select#requisition.location_id option"
	element :job_title, "input#requisition.title_id"
	elements :job_title_filter, "select#requisition.title_id_tmod"
	element :job_desc_keyword, "input#requisition.external_desc_id"
	elements :job_desc_keyword_filter, "select#requisition.external_desc_id_tmod"
	element :view_all_positions_link, "div.pull-right a.btn.btn-primary"
	element :reset_button, "button#resetButton"
	element :search_button, "button#submitButton"
	end
	
	
	def search_Job_category(jobcategory)
		
		find('div#catsearch li a',:text=>"#{jobcategory}").click
	
	end
	
	def goto_custom_search
		custom_search_link.click
	end	
	
	def custom_job_search(jobcategory,location)
		select_category(jobcategory)
		select_location(location)
		form.search_button.click
	end
	
	def select_category(jobcategory)
		#form.category_list.each {|name| name.text} 
		#form.find('select#requisition.category_id option', :text=>"#{jobcategory}").click
		#form.category_list.select(:text=>"#{jobcategory}")
		select("#{jobcategory}", :from=>'requisition.category_id')


	end

    def select_location(location)
		#form.category_list.each {|name| name.text} 
		#form.find('select#requisition.location_id option', :text=>"#{location}").click
		#form.location_list.select(:text=>"#{location}")
        select("#{location}", :from=>'requisition.location_id')

	end

	def geteachJobresultcount(index)

        job_count=Page.all(:xpath,"//div[@id='catsearch']//li['#{index}']/a/span").text
        
        Page.all(:xpath,"*//div[@id='catsearch']//li['#{index}']/a").click
        expect(@app.composite_search_page.getcount_of_SearchedJob_results.to eq(jobcount))
        

	end	

	def get_CatJob_Size_List
		sizelist = Page.all('#catsearch li').count()
        
        		puts @sizelist

    end

	end
		