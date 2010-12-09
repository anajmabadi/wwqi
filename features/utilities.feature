Feature: A set of file management utilities for development and production environments
	As an authorized user
    I want to use a number of utility functions to check the health of the site and manage its files

		Scenario: allow the user to rename files by original file name
			Given I speak English
			When I go to the admin_utilities page
				And I follow "Rename files by original file name"
			Then I should be on the rename_by_file_name page
				And I should see "Renaming completed successfully"