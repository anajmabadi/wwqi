Feature: site is community friendly with correct meta tags
	As a visitor
    I want to get a facebook friendly title
		And description
		And thumbnail 

  Scenario: show facebook friendly home page
		Given I speak English
        When I go to the home page
				Then I should have facebook meta tags