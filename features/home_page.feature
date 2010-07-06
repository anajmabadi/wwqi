Feature: home page welcomes user and provides navigation to site areas
	As a visitor
    I want to see an informative messages on the home page in Persian and English
		A copyright statement restricting rights to the content
		And a set of links for all the major pages.

  Scenario: show welcoming English home page
		Given I speak English
        When I go to the home page
        Then I should see "en, home"

	Scenario: show welcoming Persian home page
		Given I speak Persian
      	When I go to the home page
       	Then I should see "fa, home"

	Scenario: show links to the English About, Credits, and Permissions pages
		Given I speak English
			When I go to the home page
			Then I should see "en, about"
			And I should see "en, credits"
			And I should see "en, permissions"
			And I should see "en, home"
			And I should see "en, archive"
			And I should see "en, exhibits"
			And I should see "en, contact"
			And I should see "en, faq"
						
	Scenario: show links to the Persian About, Credits, and Permissions pages
		Given I speak Persian
			When I go to the home page
			Then I should see "fa, about"
			And I should see "fa, credits"
			And I should see "fa, permissions"
			And I should see "fa, home"
			And I should see "fa, archive"
			And I should see "fa, exhibits"
			And I should see "fa, contact"
			And I should see "fa, faq"			
		
	Scenario: should see a copyright statement
		Given I speak English
		When I go to the home page
		Then I should see "Copyright"
		
	Scenario: logo should link to home page
		Given I speak English
		When I go to the home page
		And I follow "en, site_title"
		Then I should be on the home page
		
  Scenario: one slide show item links to archive search
		Given I speak English
		When I go to the home page
		And I follow "en, writings"
		Then I should be on the archive filter search page

  Scenario: all slide show items link to archive search 
		Given I speak English
		And I have these subject types:
			| name	| id	|
			|	en, writings | 1 |
			|	en, legal_documents | 2 |
			|	en, photographs | 4 |			
			|	en, artworks | 3 |
			|	en, everyday_objects | 5 |
			|	en, oral_histories | 6 |
		When I go to the home page
		Then I should have valid subject type archive links
							