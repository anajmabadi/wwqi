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
			
    Scenario: Adding an item to be published
      Given I speak English
      When I create an item named Sample Item to be published
      Then "Sample Item" should be published
   
    Scenario: Editing an item 
      Given I speak English
      And I have an item titled "Sample Item"
      When I edit an item titled "Sample Item"
      Then I should have an item titled "New Title"
      
    #@javascript      
    #Scenario: Adding a comp to an item
     # Given I speak English
      #And I have items
      #When I go to the admin_items page
      #And I follow "Arghavan Baji"
      #And I add a comp titled "Chador"
      #Then I should see "Unknown woman to Jahan Ara Hajiyah Khanum"