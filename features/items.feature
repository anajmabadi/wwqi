Feature: an authorized user should be able to CRUD an item
	  As an authorized user
    	I want to be able to list, add, delete and edit items in Persian and English.
		
	  Scenario: Listing items
			Given I speak English
			When I go to the admin_items page
			Then I should be on the admin_items page
				And I should see "Items"
				
		Scenario: Showing an item
			Given I speak English
			And I have an item titled "Sample Item"
			When I go to the admin_items page
			And I follow "Sample Item"
			Then I should be on the item page for "Sample Item"
			And I should see "Items | Show"