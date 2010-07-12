Feature: an authorized user should be able to CRUD an item
	  As an authorized user
    	I want to be able to list, add, delete and edit items in Persian and English.
		
	  Scenario: Listing items
			Given I speak English
			When I go to the items page
			Then I should be on the items page
				And I should see "en, items"
	   
		Scenario: Creating an item
			Given I speak English
			When I go to the items page
			And I follow "New item"
			Then show me the page
				
		Scenario: Editing an item
		
		Scenario: Deleting an item