Given(/^I have created a job with a unique title using an api call$/) do

  job = {"category"=>"Design - Packaging", "requirements"=>"<p>job reqs</p>\n", "template"=>"f", "status"=>"Draft", "postType"=>"110", "title"=>"jess new job", "views"=>0, "applicationFlowId"=>"1", "defaultApplicationStatus"=>"Applied", "jobLevel"=>"entry", "jobType"=>"ft", "openings"=>"1", "autoClose"=>"f", "recruiterName"=>"Jess Admin", "internalJob"=>true, "externalJob"=>true, "categoryLabel"=>"Design - Packaging", "postTypeLabel"=>"Both", "jobLevelLabel"=>"Entry", "autoCloseLabel"=>"No", "jobTypeLabel"=>"Full-Time", "jobZip"=>"73118", "screenOutMsg"=>"<p>screened out</p>\n", "screenInMsg"=>"<p>screened in</p>\n", "hierarchyId"=>"21", "externalDesc"=>"<p>job desc</p>\n", "requisitionScreeningQuestions"=>["562"], "requisitionGroups"=>[1], "dynamic"=>{}, "reqReason"=>nil, "jobCode"=>nil, "location"=>nil, "jobCity"=>nil, "jobState"=>nil, "payrate"=>nil, "flsa"=>nil, "travelRequired"=>nil, "reportsTo"=>nil, "offerTemplateId"=>nil, "userId"=>nil, "hiringManager"=>nil, "requisitionApprovers"=>[], "undefined"=>nil, "requisitionUsersAccess"=>[], "fieldDate01"=>nil, "fieldText01"=>nil, "fieldText02"=>nil, "fieldText03"=>nil, "fieldText04"=>nil, "fieldText05"=>nil, "fieldText06"=>nil, "fieldText07"=>nil, "fieldText08"=>nil, "fieldText09"=>nil, "fieldText10"=>nil, "fieldText11"=>nil, "fieldText12"=>nil, "fieldText13"=>nil, "fieldText14"=>nil, "fieldText15"=>nil, "extFormGroupId"=>nil, "intFormGroupId"=>nil, "assmtPositionCode"=>"EN_TYPSS", "screenJobValue"=>nil}
  @unique_job_title = generate_unique_job_title
  job["title"] = @unique_job_title
  api_login
  @result = HTTParty.post(Capybara.app_host.to_s + "/rest/requisitions/post", :body => job.to_json,  :verify => false, :headers => { 'Content-Type' => 'application/json;charset=UTF-8', 'Accept' => 'application/json', 'Cookie' => @cookie})

end





Given(/^the post type is internal$/) do
  @job["postType"] = '100'
end

Given(/^the post type is external$/) do
   @job["postType"] = '010'
end

Given(/^the post type is both$/) do
   @job["postType"] = '110'
end

Given(/^the question group is my question group$/) do
  @job["requisitionScreeningQuestions"] = [@qg_id]
end



Given(/^the default application status is "(.*?)"$/) do |status|
  @job["defaultApplicationStatus"] = status
end


def generate_unique_job_title
  "#{DateTime.now} #{rand(1000000)} #{Capybara.app_host}"
end
