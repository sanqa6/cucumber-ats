# Rubygems and Bundler
require "rubygems"
require "bundler/setup"

# Gems
require "selenium-webdriver"
require "capybara/cucumber"
require "test/unit/assertions"
require "cucumber"
require "xmlsimple"
require "net/http"
require "nokogiri"
require "require_all"
require "capybara/rspec"
require 'capybara-screenshot/rspec'
require "site_prism"
require "json"
require 'capybara-screenshot'
require 'capybara-screenshot/cucumber'
require 'httparty'
require 'yaml'
require 'faker'

require_all 'lib' #, 'users'

CONFIG = YAML.load_file("config/config.yml")
environment = ENV['TEST_ENV'] || 'test'
CONFIG.merge! YAML.load_file("config/environments/#{environment}.yml")
#Capybara.default_driver=:chrome
brwoser = "#{CONFIG["BROWSER"]}"
if brwoser = "chrome"

Selenium::WebDriver::Chrome::Service.executable_path = "config/environments/chromedriver.exe"
end
#Selenium::WebDriver::internetexplorer::Service.executable_path = "config/environments/IEDriverServer.exe"
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :"#{CONFIG["BROWSER"]}")
end



Capybara.default_driver = :selenium
#Capybara.default_driver = :sauce
#Capybara.app_host = 'https://cert.hrapply.com/findlyats'
Capybara.app_host = "#{CONFIG['BASE_URL']}/#{CONFIG['CLIENT']}"
Capybara.default_wait_time = CONFIG["TIMEOUT"]
Capybara.run_server = false

Capybara.save_and_open_page_path = "report"
# Customize screenshot file name
Capybara::Screenshot.register_filename_prefix_formatter(:cucumber) do |scenario|
  if scenario.instance_of?(Cucumber::Ast::OutlineTable::ExampleRow)
    scenario_name = scenario.scenario_outline.name.gsub(/[^\w\-]/, ' ')
    scenario_name += "-Example#{scenario.name.gsub(/\s*\|\s*/, '-')}".chop
  else
    scenario_name = scenario.name.gsub(/[^\w\-]/, ' ')
  end
  scenario_name
end


# test_context to store any in flight text context and variables.  This will be set to nil at exit.
def test_context
	@test_context ||= Hash.new
end

# wait for ajax requests to finish
def wait_for_ajax
	Timeout.timeout(Capybara.default_wait_time) do
    loop until finished_all_ajax_requests?
    end
end

def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
end
