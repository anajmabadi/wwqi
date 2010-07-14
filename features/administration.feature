Feature: Overview page for the administration of the site
	As an authorized visitor
    I want to see an overview page of my Administrative options in English and Persian

		Scenario: show the administration page in both languages
				Given I speak English
					And I have pages
				When I go to the admin page
		    Then I should be on the admin page
					And I should see "Administration"
				Given I speak Persian
					And I have pages
				When I go to the admin page
		    Then I should be on the admin page
					And I should see "حکومت"

		Scenario: offer a utilities page from the administration menu
			Given I speak English
				And I have pages
			When I go to the admin page
				And I follow "Utilities"
			Then I should be on the utilities page
				And I should see "Utilities"