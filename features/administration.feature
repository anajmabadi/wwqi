Feature: Overview page for the administration of the site
	As an authorized visitor
    I want to see an overview page of my Administrative options in English and Persian

		Scenario: show the administration page in both languages
				Given I speak English
					And I have pages
				When I go to the admin page
		    Then I am on the admin page
					And I should see "en, admin_description"
				Given I speak Persian
					And I have pages
				When I go to the admin page
		    Then I am on the admin page
					And I should see "fa, admin_description"
											
		Scenario: handle a missing admin page gracefully
			Given I speak English
				And I have no pages
			When I go to the admin page
	    	Then I am on the home page	

		Scenario: offer a utilities page from the administration menu
			Given I speak English
				And I have pages
			When I go to the admin page
				And I follow "en, utilities"
			Then I am on the utilities page
				And I should see "en, utilities_description"