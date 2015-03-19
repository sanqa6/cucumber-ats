module Api_login
	include Helpers

	def api_login
		login_to_new_api()
	  login_to_legacy_api()
	end

	def login_to_legacy_api
		credentials = JSON.generate({
			errpage: "Setup.ats",
			nextPage: "HOME",
			uname: CONFIG['ADMIN'],
			password: CONFIG['ADMIN_PASSWORD']
		})

		@kblogin = http_post(
			"#{Capybara.app_host}/Login.ats",
			{
				body: JSON.parse(credentials),
				verify: false,
				headers: {
					'Content-Type' => 'application/x-www-form-urlencoded',
					'Connection' => 'keep-alive',
					'cookie' => "hideNav=true; #{@cookie}"
				}
			})
	end

	def login_to_new_api
		credentials = JSON.generate({
			username: CONFIG['ADMIN'],
			password: CONFIG['ADMIN_PASSWORD'],
			domain: "RECRUITER"
		})

		@cookie = http_post(
			"#{Capybara.app_host}/ats/login",
			{
				body: credentials,
				verify:false,
				headers: {
					'Content-Type' => 'application/json;charset=UTF-8',
					'Connection' => 'keep-alive',
					'Transfer-Encoding' => 'chunked'
				}
			}).headers['set-cookie'].to_s[0..42]
	end
end

 World(Api_login)
