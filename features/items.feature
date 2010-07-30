Feature: an authorized user should be able to CRUD an item
	  As an authorized user
    	I want to be able to list, add, delete and edit items in Persian and English.
		
	  Scenario: Listing items
			Given I speak English
			When I go to the items page
			Then I should be on the items page
				And I should see "Items"
				
		Scenario: Showing an item
			Given I speak English
			And I have an item titled "Sample Item"
			When I go to the items page
			And I follow "Sample Item"
			Then I should be on the item page for "Sample Item"
			And I should see "Women's Worlds in Qajar Iran | Items | Show"
	   
		Scenario: Creating an item
			Given I speak English
			And I am on the items page
			When I follow "New item"
			And I fill in "Title" with "Sample Item"
			And I fill in "Pages" with "1"
			And I fill in "Accession num" with "abcdfg"
			And I press "Create Item"
			Then I should see "Item was successfully created."
			And I should be on the item page for "Sample Item"
			And I should see "Women's Worlds in Qajar Iran | Items | Show"
			
		Scenario: Creating an item without a title should fail
			Given I speak English
				And I am on the items page
			When I follow "New item"
				And I fill in "Accession num" with "abcdfgh"
				And I fill in "Pages" with "1"
				And I press "Create Item"
				And I should see "Title can't be blank"	
		
		Scenario: Creating an item without an accession num should fail
			Given I speak English
				And I am on the items page
			When I follow "New item"
				And I fill in "Title" with "Sample Item" 
				And I fill in "Pages" with "3"
				And I press "Create Item"
				And I should see "Accession num can't be blank"			
				
		Scenario: Creating an item without pages should fail
			Given I speak English
				And I am on the items page
			When I follow "New item"
				And I fill in "Title" with "Sample Item" 
				And I fill in "Accession num" with "abcdf"
				And I fill in "Pages" with ""
				And I press "Create Item"
				And I should see "Pages can't be blank"					
				
		Scenario: Editing an item
			Given I speak English
				And I have an item titled "Sample Item"
				And I am on the items page
			When I follow "Sample Item"
				And I follow "Edit"	
				And I fill in "Title" with "Sample Item 2"
				And I press "Update Item"
			Then I should see "Item was successfully updated."
				And I should be on the item page for "Sample Item 2" 
		
		Scenario: Editing an item with invalid properties should fail
			Given I speak English
				And I have an item titled "Sample Item"
				And I am on the items page
			When I follow "Sample Item"
				And I follow "Edit"	
				And I fill in "Title" with ""
				And I fill in "Pages" with ""
				And I press "Update Item"
			Then I should see "Title can't be blank"
			  And I should see "Pages can't be blank"
			  And I should see "Pages must be a number"
				
		Scenario: Deleting an item
			Given I speak English
				And I have an item titled "Sample Item"
				And I am on the items page
			When I follow "Sample Item"
				And I follow "Delete"
			Then I should see "Item was deleted"
			  And I should not see "Sample Item"	