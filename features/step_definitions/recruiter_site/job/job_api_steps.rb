Given(/^I have created an internal and external job$/) do
  api_login
  step "I have all the information I need to create a job"
  @result = http_post(
    "#{Capybara.app_host.to_s}/rest/requisitions/post",
    {
      body: @job.to_json,
      verify: false,
      headers: get_request_headers_for_json()
    })
  @unique_job_title = @result["title"]
end

And(/^I post that job$/) do
  api_login
  step "I have all the information I need to create a job"
  @result = http_post(
    "#{Capybara.app_host.to_s}/rest/requisitions/post",
    {
      body: @job.to_json,
      verify: false,
      headers: get_request_headers_for_json()
    })
  #@job_id = @result[''] ID NOT AVAILABLE IN API UNTIL API IS REWRITTEN
  @unique_job_title = @result["title"]
end

And(/^I have all the information I need to create a job$/) do
  step "I have created a question group using the api"
  @job = {
    title: "#{Faker::Name.title}-#{DateTime.now} #{rand(1000000)}",
    category: "Design - Packaging",
    requirements: "<p>job reqs</p>\n",
    template: "f",
    status: "Draft",
    postType: "110",
    views: 0,
    applicationFlowId: "1",
    defaultApplicationStatus: "Applied",
    jobLevel: "entry",
    jobType: "ft",
    openings: "1",
    autoClose: "f",
    recruiterName: "Jess Admin",
    internalJob: true,
    externalJob: true,
    categoryLabel: "Design - Packaging",
    postTypeLabel: "Both",
    jobLevelLabel: "Entry",
    autoCloseLabel: "No",
    jobTypeLabel: "Full-Time",
    jobZip: "73118",
    screenOutMsg: "<p>screened out</p>\n",
    screenInMsg: "<p>screened in</p>\n",
    hierarchyId: "21",
    externalDesc: "<p>job desc</p>\n",
    requisitionScreeningQuestions: [
      @question_group['questionGroupId']
    ],
    requisitionGroups: [1],
    dynamic: {},
    reqReason: nil,
    jobCode: nil,
    location: nil,
    jobCity: nil,
    jobState: nil,
    payrate: nil,
    flsa: nil,
    travelRequired: nil,
    reportsTo: nil,
    offerTemplateId: nil,
    userId: nil,
    hiringManager: nil,
    requisitionApprovers: [],
    undefined: nil,
    requisitionUsersAccess: [],
    fieldDate01: nil,
    fieldText01: nil,
    fieldText02: nil,
    fieldText03: nil,
    fieldText04: nil,
    fieldText05: nil,
    fieldText06: nil,
    fieldText07: nil,
    fieldText08: nil,
    fieldText09: nil,
    fieldText10: nil,
    fieldText11: nil,
    fieldText12: nil,
    fieldText13: nil,
    fieldText14: nil,
    fieldText15: nil,
    extFormGroupId: nil,
    intFormGroupId: nil,
    assmtPositionCode: "EN_TYPSS",
    screenJobValue: nil
  }
end
