Feature: an authorized user should be able to CRUD an item
	  As an authorized user
    	I want to be able to list, add, delete and edit items in Persian and English.
		
	  Scenario: Listing items
			Given I speak English
			When I go to the items page
			Then I should be on the items page
				And I should see "Items"
	   
		Scenario: Creating an item
			Given I speak English
			And I am on the items page
			When I follow "New item"
			And I fill in "Title" with "Sample Item"
			And I fill in "Pages" with "1"
			And I press "Create Item"
			Then I should see "Item was successfully created."
			And I should be on the item page for "Sample Item"
			And I should see "Women's Worlds in Qajar Iran | Items | Show"
				
		Scenario: Editing an item
		
		Scenario: Deleting an item