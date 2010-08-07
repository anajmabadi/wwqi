Feature: 	An archive landing page that orients the user to the many ways to view the collection, offers keyword searching, and social networking style views of objects currently being viewed, popular searches.
	As a visitor to the site
    I want to see an orientation page
			And be able to quick search
			And be able to browse all items in the collection
			And be able to click one of the six major genres
			And be able to view a timeline of periods
			And be able to views indexes of collections, people, locations, and subjects
			And be able to view social networking style activities and searches

		Scenario: should be able to search the archive by keyword
			Given I speak English
				And I have items
			When I go to the archive page
				And I fill in "quick_search" with "tragic" 
			  And I press "Search"
			Then I should see "archive browser"	
				And I should see "A tragic story"
					
		Scenario: open an orientation page when I hit archive on the home page
			Given I speak English
			When I go to the archive page
			  And I follow "Browse Archive"
			Then I should see "archive browser"
				
	  Scenario: all subject type links take you to the correct archive browser page 
			Given I speak English
				And I have subject types
				And I have these subject types:
					| name	| id	|
					|	Writings | 1 |
					|	Legal Documents | 2 |
					|	Photographs | 4 |			
					|	Artworks | 3 |
					|	Everyday objects | 5 |
					|	Oral histories | 6 |
			When I go to the archive page
			Then I should have valid subject type archive links from archive
			
	  Scenario: all period links take you to the correct archive browser page 
			Given I speak English
				And I have periods
				And I have items
				And I have these periods:
					| name	| id	| items_count | 
					|	Aqa Muhammad Khan Period | 1 | 0 |
					|	Fath 'Ali Shah Period | 2 | 0 |
					|	Pre-Qajar Period Period | 3 | 0 |
					|	Muhammad Shah Period | 4 | 0 |
					|	Nasir al-Din Shah Period | 5 | 0 |
					|	Muzaffar al-Din Shah Period | 6 | 0 |
					|	Muhammad 'Ali Shah Period| 7 | 0 |
					| Ahmad Shah Period | 8 | 0 |
					| Early Pahlavi Period | 9 | 0 |
			When I go to the archive page
			Then I should have valid period archive links		
			
			