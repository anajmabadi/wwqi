Feature: Manage formats
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new format
    Given I am on the new format page
    When I fill in "Name" with "name 1"
    And I fill in "Extension" with "extension 1"
    And I uncheck "Publish"
    And I fill in "Notes" with "notes 1"
    And I press "Create"
    Then I should see "name 1"
    And I should see "extension 1"
    And I should see "false"
    And I should see "notes 1"

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for 
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
  Scenario: Delete format
    Given the following formats:
      |name|extension|publish|notes|
      |name 1|extension 1|false|notes 1|
      |name 2|extension 2|true|notes 2|
      |name 3|extension 3|false|notes 3|
      |name 4|extension 4|true|notes 4|
    When I delete the 3rd format
    Then I should see the following formats:
      |Name|Extension|Publish|Notes|
      |name 1|extension 1|false|notes 1|
      |name 2|extension 2|true|notes 2|
      |name 4|extension 4|true|notes 4|
