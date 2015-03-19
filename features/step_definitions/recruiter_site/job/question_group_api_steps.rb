Given(/^I have created a question group using the api$/) do
  api_login

  step "I have all the information I need to create a question group"
  @response = http_post(
    "#{Capybara.app_host.to_s}/rest/questiongroups",
    {
        body: @question_group.to_json,
        verify: false,
        headers: get_request_headers_for_json()
    })
  @question_group = @response
end

Given(/^I have all the information I need to create a question group$/) do
  @question_group = {
    name: "#{CONFIG["ADMIN"]} questions - #{(DateTime.now).to_s}",
    generalQuestionWrappers: [
      {
        type: "HRadio",
        required: "t",
        question: "Is the group more important than the individual?",
        sortOrder: 0,
        active: "t",
        generalOptionWrappers: [
          {
            answer: "Yes",
            weight: 0,
            sortOrder: 0,
            active: "t"
          },
          {
            answer: "No",
            weight: 0,
            sortOrder: 1,
            active: "t"
          }
        ],
        disclaimer: "Please select from the radio buttons",
        sensitivity: "NOT_SENSITIVE",
        mappedProperty: nil
      },
      {
        type: "TArea",
        required: "t",
        question: "Why?",
        sortOrder: 1,
        active: "t",
        generalOptionWrappers: [

        ],
        disclaimer: "Please let us know why.",
        sensitivity: "NOT_SENSITIVE",
        mappedProperty: nil
      }
    ],
    active: "t",
    questionGroupTypeId: 1
  }
end
