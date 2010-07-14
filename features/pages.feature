Feature: Informational pages show information to the User in English and Persian
	As a visitor
    I want to see an informative message on informational pages in Persian and English
		
	 Scenario: show welcoming English about page
			Given I speak English
				And I have pages
			When I go to the about page
	    	Then I should be on the about page
					And I should see "About"

	 Scenario: gracefully redirect to the Home page when pages content is missing
			Given I speak English
				And I have no pages
			When I go to the about page
	    	Then I should be on the home page
					And I should see "About Us"
								
	Scenario: show welcoming Persian about page
			Given I speak Persian
			 	And I have pages
			When I go to the about page
      Then I should be on the about page
				And I should see "در مورد صفحه"
		
  Scenario: show informative English credits page
		Given I speak English
			And I have pages
        When I go to the credits page
        Then I should be on the credits page
				And I should see "Credits"

  Scenario: show informative English permissions page
		Given I speak English
			And I have pages
        When I go to the permissions page
        Then I should be on the permissions page
				And I should see "Permissions"

  Scenario: show informative English faq page
		Given I speak English
			And I have pages
        When I go to the faq page
        Then I should be on the faq page
				And I should see "FAQ"		

	Scenario: show informative English contact page
		Given I speak English
			And I have pages
        When I go to the contact page
        Then I should be on the contact page
				And I should see "Contact"