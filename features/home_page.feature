Feature: home page welcomes user and provides navigation to site areas
	As a visitor
    I want to see an informative messages on the home page in Persian and English
		A copyright statement restricting rights to the content
		And a set of links for all the major pages.

  Scenario: show welcoming English home page
		Given I speak English
        When I go to the home page
        Then I should see "Home"

	Scenario: show welcoming Persian home page
		Given I speak Persian
      	When I go to the home page
       	Then I should see "خانه"

	Scenario: show links to the English About, Credits, and Permissions pages
		Given I speak English
			When I go to the home page
			Then I should see "About"
			And I should see "credits"
			And I should see "permissions"
			And I should see "Home"
			And I should see "archive"
			And I should see "exhibits"
			And I should see "contact"
			And I should see "FAQ"
						
	Scenario: show links to the Persian About, Credits, and Permissions pages
		Given I speak Persian
			When I go to the home page
			Then I should see "درباره ما"
			And I should see "همکاران"
			And I should see "مجوزات حقوقی"
			And I should see "خانه"
			And I should see "آرشی"
			And I should see "نمایشگاه ها"
			And I should see "تماس با ما"
			And I should see "سؤالات متداول"			
		
	Scenario: should see a copyright statement
		Given I speak English
		When I go to the home page
		Then I should see "Copyright"
		
	Scenario: logo should link to home page
		Given I speak English
		When I go to the home page
		And I follow "Women's Worlds in Qajar Iran"
		Then I should be on the home page
		
  Scenario: one slide show item links to archive search
		Given I speak English
		When I go to the home page
		And I follow "Writings"
		Then I should be on the archive filter search page

  Scenario: all slide show items link to archive search 
		Given I speak English
		And I have these subject types:
			| name	| id	|
			|	Writings | 1 |
			|	Legal Documents | 2 |
			|	Photographs | 4 |			
			|	Artworks | 3 |
			|	Everyday Objects | 5 |
			|	Oral Histories | 6 |
		When I go to the home page
		Then I should have valid subject type archive links
							