Keeper Functional Tests
=======================

This project contains BDD functional tests for Keeper.


Environment Setup
-----------------

 1. Install Firefox.
 2. Install Ruby 1.9.3+.
    - Mac OSX: You want to install ruby via [rbenv](https://github.com/sstephenson/rbenv), which can be installed via [Homebrew] (http://brew.sh/).
 3. Install Bundler:

        $ gem install bundler

 4. Install project dependencies:

        $ bundle install

    - Ubuntu: You will need to first install nokigiri system dependencies:

            $ apt-get install -y libxml2-dev libxslt-dev
            $ bundle config build.nokogiri --use-system-libraries


Running Cucumber tests
----------------------

To run all tests, at a terminal run:

    $ bundle exec cucumber

To generate test report with failure screenshots, make sure "html-report"
directory exists and run:

    $ bundle exec cucumber --format html --out html-report/index.html

To run a specific feature, run:

    $ bundle exec cucumber features/recruiter_login.feature

To run a specific feature not directly under `features` directory, you need to explicitly specify the ruby library path as below:

    $ bundle exec cucumber -r features features/candidate_login_features/relogin_from_different_pages.feature

To run with local development environment, you need to specify the environment as below:

    $ TEST_ENV=development bundle exec cucumber

    //For Windows user
    $ SET TEST_ENV=development&& bundle exec cucumber


Running With Docker
-------------------

The Dockerfile in the "docker" directory will build a Docker image containing
all the required platform dependencies such as Ruby and Firefox, and, when run
as a container, will execute the functional tests. To build the image, run:

    $ docker build -t keeper-functional-testing docker

A container must be run with the root dir of this project mounted as a volume
at /workspace. To run a container, run:

    $ docker run -v `pwd`:/workspace keeper-functional-testing


Framework
---------

- Directory Structure

```
project                        contains project related files i.e. Gemfiles, README.md
	config                     yml file(s)
	docker                     Dockerfile (docker environment)
	features                   feature files.  this is where tests are written in gherkin
		step_definitions       test implementation
		support                environment settings and hooks
	html-report                html test report and captured screenshots
	lib
		modules                ruby files for helpers, modules, etc.
		pages                  page object ruby files
```
BDD Framework (Behaviour Driven Development)
- cucumber is used describe the behaviour, write and execute test. See
  http://cukes.info/.

Web Application Testing Framework
- Capybara simulates how real users interacts with a web application using
  built in methods that are implemented to closely relate to a user action.
  Selenium-Webdriver build in support. See https://github.com/jnicklas/capybara.

Page Object
- Site Prism is a page object model for capybara. See
  https://github.com/natritmeyer/site_prism.

Scripting Language
- Ruby. See https://www.ruby-lang.org/en/.


Naming Convention
-----------------
[This Ruby coding style](https://github.com/bbatsov/ruby-style-guide) is used. Below are the basic naming convention:

- Use `snake_case` for symbols, methods and variables.
- Use `CamelCase` for classes and modules. (Keep acronyms like HTTP, RFC, XML uppercase.)
- Use `snake_case` for naming files, e.g. `hello_world.rb`.
- Use `snake_case` for naming directories, e.g. `lib/hello_world/hello_world.rb`.
- Aim to have just a single class/module per source file. Name the file name as the class/module, but replacing CamelCase with snake_case.
- Use `SCREAMING_SNAKE_CASE` for other constants.
- The names of predicate methods (methods that return a boolean value) should end in a question mark. (i.e. `Array#empty?`). Methods that don't return a boolean, shouldn't end in a question mark.
- The names of potentially dangerous methods (i.e. methods that modify self or submit, `update_type!`) should end with an exclamation mark if there exists a safe version of that dangerous method.
- Define the non-bang (safe) method in terms of the bang (dangerous) one if possible.

Some Ruby Tips For Java/JavaScript Developers
------------------------
Few common coding style for Java/JavaScript developers

### Avoid `return` at end of method

**Bad**
```Ruby
def some_method(some_arr)
  return some_arr.size
end
```

**Good**
```Ruby
def some_method(some_arr)
  some_arr.size
end
```

### Use string interpolation instead of string concatenation

**Bad**
```Ruby
email_with_name = user.name + ' <' + user.email + '>'
```

**Good**
```Ruby
email_with_name = "#{user.name} <#{user.email}>"
```

### Prefer hash literal syntax instead of strings as hash keys
**Bad**
```Ruby
# bad to use string
hash = { 'one' => 1, 'two' => 2, 'three' => 3 }

# bad to direct use symbols
hash = { :one => 1, :two => 2, :three => 3 }
```

**Good**
```Ruby
hash = { one: 1, two: 2, three: 3 }
```

Best Practices
-------------

### Write declarative features
Scenarios should be written like a user would describe them.

Beware of scenarios that only describe clicking links and filling in form fields, or of steps that contain code or CSS selectors. This is just another variant of programming, but certainly not a feature description.


**Bad**

```Cucumber
Scenario: Adding a todo item
    Given: I have a todo list named "Mondays list"
    When I go to the home page
    And I fill in "username" with "dave"
    And I fill in "password" with "secret"
    And I press "Log In"
    And I go to the todo page
    And I click on link "Mondays list"
    And I fill in "todo" with "Grab some milk"
    And I press "Add todo"
    Then I should see "Todo item added successfully"
```

**Good**
```Cucumber
Scenario: Adding a todo item
    Given: I have a todo list
    And I am logged in as a normal user
    When I add a todo item
    Then It should be added to the todo list
```

### Use `As a <role>, I want <goal/desire> So that <benefit>` format for feature description
Describe feature in user story style. Starts the feature and gives it a title, then follow with user story format.

**Bad**
```Cucumber
Feature: Create an account from search page on external website

  Scenario: ...
```

**Good**
```Cucumber
Feature: Create an account from search page on external website
  As a candidate
  I want to create an account for me
  So that I can apply job

  Scenario: ...
```

### Use `should` in each `Then` and following `And` steps
The purpose of `Then` steps is to observe outcomes and verify result. Using `should` word as a convention makes it easy to understand, and make sure do verification in implementation step.

**Bad**
```Cucumber
Then My job is displayed in the table
```

**Good*
```Cucumber
Then My job should be displayed in the table
```

### Capitalize first letter of every step
Each step is independant, capitalize first letter makes a nice format.

**Bad**
```Cucumber
Then my job should be displayed in the table
```

**Good**
```Cucumber
Then My job should be displayed in the table
```


### Use page object model
Don't write implementation in step definition, use page object model.

**Bad**

```Ruby
When(/^I search for my job on the recruiter site$/) do
  visit path_to('manage jobs')
  find('a', :text => 'Filter Jobs').click
  fill_in('users-id-search', :with=>"")
  page.find('#users-id-search').native.send_keys(:backspace)
  fill_in('requisition.title', :with => @unique_job_title)
  click_button('Search')
end
```

**Good**

_job_steps.rb_
```Ruby
When(/^I search for my job on the recruiter site$/) do
  @app.manage_job_page.load
  @app.manage_job_page.search @unique_job_title
end
```
_manage_job_page.rb_
```Ruby
def search(job_title)
  find('a', :text => 'Filter Jobs').click
  fill_in('users-id-search', :with=>"")
  page.find('#users-id-search').native.send_keys(:backspace)
  fill_in('requisition.title', :with => @unique_job_title)
  click_button('Search')
end
```

### Use background
If all the scenario in one feature file have the same steps, put them in the background.

**Bad**
```Cucumber
Scenario: Foo
  Given I am logged in as an admin
  And ....

Scenario: Bar
  Given I am logged in as an admin
  And ....
```

**Good**
```Cucumber
Background:
  Given I am logged in as an admin

Scenario: Foo
  Given ....

Scenario: Bar
  Given ....
```

### Organize features and step definition
Features and step definition should be organised by business structure.

They should share the same structure.

**Bad**
```
features/
    candidate_site_login.feature
    recruiter_site_login.feature
    create_job.feature
    create_template.feature
step_definitions/
    login_steps.rb
    create_job_steps.rb
    create_template_steps.rb
```

**Good**
```
features/
    candidate_site/
        login/
          login.feature
    recruiter_site/
        login/
            login.feature
        job/
            create_job.feature
        job_template/
            create_job_template.feature
step_definitions/
    candidate_site/
        login/
          login_steps.rb
    recruiter_site/
        login/
            login_steps.rb
        job/
            create_job_steps.rb
        job_template/
            create_job_template_steps.rb
```

### Use Tags
Tags are a great way to organise your features and scenarios.

**Good**
```Cucumber
@smoke @regression @offer @template
Feature: Offer template management
```

### Avoid to use step params
Step params is a smell which the feature is not declarative.

The parameter in feature should **not** be used as **implementation parameter**.

**Bad**
```Cucumber
Given I complete the pollinator using email "externalauto@findly.com"
```

**Good**
```Cucumber
Given I complete the pollinator form using a valid email
```


### Avoid to use scenario outlines
A Scenario Outline provides a parametrized scenario script. However, it easily become an anti-pattern if you use it too many.

Each scenario with example actually means a different scenario. It's better to **use scenario with a meaningful name** instead of using scenario example.

Scenario outlines uses step params, which should avoid to use.

Beware of feature that only has one scenario but have a long list of examples. It could be a smell that too many different scenario are put together.

### Avoid to use data tables
Data tables provides data for implementation. It is against the rule of feature should be declarative and business focus.

Feature should not provide any detail implementation or data for testing.


### Test locally
It is easy to test again local development instead of QA environment.

```bash
$ TEST_ENV=development bundle exec cucumber
```

```bash
#Only test one feature
$ TEST_ENV=development bundle exec cucumber -r features features/candidate_login_features/relogin_from_different_pages.feature
```

### Test only one scenario
You may want to test only one scenario when developing it. With `tag` you can only test it.

```Cucumber
 @test-this-only
 Scenario: .....
```

```bash
bundle exec cucumber -r features -t @test-this-only
```

### Use `@context`
`Context` class provides common context information for cucumber steps. You should use `@context` for common context information.

```ruby
 @context.site = :external
```

```ruby
Then(/^I should be redirect to home page$/) do
  step 'I should be redirect to internal home page' if @context.internal?
  step 'I should be redirect to external home page' if @context.external?
end
```

### Use Capybara `find` whenever possible
`find` will wait for a set amount of time and continuously retry finding the element until either the element is found or the time expires.

**Bad**

```ruby
first(".active").click
```

**Good**
```ruby
find(".active", match: :first).click
```


Interactive Browser Testing
---------------------------

Accelerate the development of Capybara browser commands with interactive Ruby
interpreter (IRB):

 1. Run interactive Ruby:

        $ bundle exec irb

 2. From the Ruby prompt, set up Capybara:

    ```ruby
    require 'capybara/dsl'
    include Capybara::DSL
    Capybara.default_driver = :selenium
    ```

 3. Use Capybara to manipulate a browser and interact with the DOM:

    ```ruby
    visit 'https://westkeep01.findly.com/keeperbase/Setup.ats'
    fill_in('uname', :with => 'jgreene')
    fill_in('password', :with => 'jgreene')
    find(:xpath, "//a[text()='Log In']").click
    ```

See also http://tom-clements.com/blog/2012/02/25/capybara-on-the-command-line-live-browser-testing-from-irb/.
