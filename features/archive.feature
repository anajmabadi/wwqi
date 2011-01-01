Feature: 	An archive landing page that orients the user to the many ways to view the collection, offers keyword searching, and social networking style views of objects currently being viewed, popular searches.
	As a visitor to the site
    I want to see an orientation page
			And be able to quick search
			And be able to browse all items in the collection
			And be able to click one of the six major genres
			And be able to view a timeline of periods
			And be able to views indexes of collections, people, locations, and subjects
			And be able to view social networking style activities and searches

		Scenario: open an orientation page when I hit archive on the home page
			Given I speak English
				And I have items
				And I have collections
				And I have subject types
				And I have periods
			When I go to the archive page
			  And I follow "Browse Archive"
			Then I should see "Displaying items"
						
		Scenario: should be able to search the archive by keyword
			Given I speak English
				And I have items
				And I have collections
				And I have subject types
				And I have periods
			When I go to the archive page
				And I fill in "keyword_filter" with "tragic" 
			  And I press "search"
			Then I should see "Displaying items"	
				And I should see "A tragic story"
				
	  Scenario: all period links take you to the correct archive browser page 
			Given I speak English
				And I have items
				And I have collections
				And I have subject types
				And I have periods
				And I have these periods:
					| name	| id	| items_count | 
					|	Aqa Muhammad Khan | 1 | 0 |
					|	Fath 'Ali Shah | 2 | 0 |
					|	Pre-Qajar | 3 | 0 |
					|	Muhammad Shah | 4 | 0 |
					|	Nasir al-Din Shah | 5 | 0 |
					|	Muzaffar al-Din Shah | 6 | 0 |
					|	Muhammad 'Ali Shah | 7 | 0 |
					| Ahmad Shah | 8 | 0 |
					| Pahlavi | 9 | 0 |
			When I go to the archive page
			Then I should have valid period archive links
			
			Scenario: show most popular items
				Given I speak English
					And I have items
					And I have collections
					And I have subject types
					And I have periods
					And I have activities
				When I go to the archive page
				  And I follow "Most Popular"
				Then I should see "Search Filters"

			Scenario: show recent additions
				Given I speak English
					And I have items
					And I have collections
					And I have subject types
					And I have periods
					And I have activities
				When I go to the archive page
				  And I follow "Recent Additions"
				Then I should see "Search Filters"

			Scenario: show staff favorites
  			Given I speak English
  				And I have items
  				And I have collections
  				And I have subject types
  				And I have periods
  				And I have activities
  			When I go to the archive page
  			  And I follow "Staff Favorites"
  			Then I should see "Search Filters"
@dev  			
      Scenario: show my archive selections
        Given I speak English
          And I have items
          And I have collections
          And I have subject types
          And I have periods
          And I have activities
        When I go to the archive page
          And I follow "My Archive"
        Then I should see "Search Filters"