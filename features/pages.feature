Feature: Informational pages show information to the User in English and Persian
	As a visitor
    I want to see an informative message on informational pages in Persian and English

		Scenario: handle a missing page gracefully
				Given I speak English
					And I have no pages
				When I go to the about page
		    	Then I am on the home page
		
	 Scenario: show welcoming English about page
			Given I speak English
				And I have pages
			When I go to the about page
	    	Then I am on the about page
					And I should see "en, about_description"

	Scenario: show welcoming Persian about page
			Given I speak Persian
			 	And I have pages
			When I go to the about page
      Then I am on the about page
				And I should see "fa, about_description"
		
  Scenario: show informative English credits page
		Given I speak English
			And I have pages
        When I go to the credits page
        Then I am on the credits page
				And I should see "en, credits_description"

	Scenario: show information Persian credits page
		Given I speak Persian
			And I have pages
      	When I go to the credits page
       	Then I am on the credits page
				And I should see "fa, credits_description"

  Scenario: show informative English permissions page
		Given I speak English
			And I have pages
        When I go to the permissions page
        Then I am on the permissions page
				And I should see "en, permissions_description"

	Scenario: show information Persian permissions page
		Given I speak Persian
			And I have pages
      	When I go to the permissions page
       	Then I am on the permissions page
				And I should see "fa, permissions_description"

  Scenario: show informative English faq page
		Given I speak English
			And I have pages
        When I go to the faq page
        Then I am on the faq page
				And I should see "en, faq_description"

	Scenario: show information Persian faq page
		Given I speak Persian
			And I have pages
      	When I go to the faq page
       	Then I am on the faq page
				And I should see "fa, faq_description"				

	Scenario: show informative English contact page
		Given I speak English
			And I have pages
        When I go to the contact page
        Then I am on the contact page
				And I should see "en, contact_description"

	Scenario: show information Persian contact page
		Given I speak Persian
			And I have pages
      	When I go to the contact page
       	Then I am on the contact page
				And I should see "fa, contact_description"