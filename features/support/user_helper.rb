module UserHelper

  def create_user(username,password,role,first_name,last_name,email)

    user_helper = UserHelperService.new
    user_helper.create_user username,password,role,first_name,last_name,email

  end

  class UserHelperService

    def create_user(username,password,role,first_name,last_name,email)
      cookie = login()
      admin_user_edit_page = HTTParty.get((Capybara.app_host) + "/AdminUserEdit.jsp?link=-1&page=UserManager.jsp&op=reset&hideNav=true", :verify => false, :headers => {'Connection' => 'keep-alive', 'cookie' => 'hideNav=true; ' + cookie})
      response_body = admin_user_edit_page.response.body
      page = Nokogiri::HTML(response_body)
      form_token = extract_token(page)
      role_id = extract_role(page,role)
      create_params = create_user_params(form_token,username,password,role_id,first_name,last_name,email)
      HTTParty.post((Capybara.app_host) + "/AdminUser.ats?ndx=0&admin=update", :body => create_params, :verify => false, :headers => {'Content-Type' => 'application/x-www-form-urlencoded', 'Connection' => 'keep-alive', 'cookie' => 'hideNav=true; ' + cookie})
    end

    private

    def login()
      kbcredentials = JSON.parse('{"errpage":"Setup.ats","nextPage":"HOME", "uname":"'+CONFIG["ADMIN"]+'", "password":"'+CONFIG["ADMIN_PASSWORD"]+'"}')
      credentials = JSON.parse('{"username":"'+CONFIG["ADMIN"]+'","password":"'+CONFIG["ADMIN_PASSWORD"]+'","domain":"RECRUITER"}')
      cookie = HTTParty.post((Capybara.app_host) + "/ats/login", :body => credentials.to_json, :verify => false, :headers => { 'Content-Type' => 'application/json;charset=UTF-8', 'Connection' => 'keep-alive', 'Transfer-Encoding' => 'chunked'}).headers['set-cookie'].to_s[0..42]
      kblogin = HTTParty.post((Capybara.app_host) + "/Login.ats", :body => kbcredentials, :verify => false, :headers => {'Content-Type' => 'application/x-www-form-urlencoded', 'Connection' => 'keep-alive', 'cookie' => 'hideNav=true; ' + cookie})
      cookie
    end

    def extract_token(page)
      page.css('input[name="formToken"]')[0]['value']
    end

    def extract_role(page,role_name)
      role_id = ""
      page.css('select[name="users.groups_id"] option').each do |option|
        if(option.text == role_name)
          role_id = option['value']
        end
      end
      role_id
    end

    def create_user_params(formToken,username,password,role_id,first_name,last_name,email)
      JSON.parse('{"formToken":"'+formToken+'",
      "users.uname":"'+username+'",
      "users.password":"'+password+'",
      "users.hierarchy_id":"1",
      "hierarchyselect":"",
      "hselectedname":"",
      "bo":"users",
      "users.groups_id":"'+role_id+'",
      "users.first_name":"'+first_name+'",
      "users.last_name":"'+last_name+'",
      "users.email":"'+email+'",
      "users.status":"Active",
      "users.pw_change":"f",
      "radiousers.pw_change": "",
      "usersearch": "",
      "users.wf_delegate": "",
      "x":"58",
      "y":"14",
      "nextPage":"UserManager.jsp?op=reset",
      "errPage":"AdminUserEdit.jsp?link=-1",
      "users.req_group_id":"1"}')
    end
  end
end

World(UserHelper)