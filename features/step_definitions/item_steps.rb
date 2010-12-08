Given /^I have an item titled "([^"]*)"$/ do |arg1|
  @item = Item.create!(:title => arg1, :pages => 1, :accession_num => "abcdefg", :publish => true)
end

When /^I create an item named Sample Item to be published$/ do
  visit admin_items_path
  click_link 'New'
  fill_in 'Title en', :with => 'Sample Item'
  fill_in 'Title fa', :with => 'Sample Item fa'
  fill_in 'Accession num', :with => 'abcdf'
  check 'Publish'
  click_button 'Create Item'
end

Then /^"([^"]*)" should be published$/ do |arg1|
  visit admin_items_path
  click_link "Sample Item"
  response.should contain("abcdf")
  response.should contain("Sample Item")
  response.should contain("Publish: true")
end

When /^I edit an item titled "([^"]*)"$/ do |arg1|
  visit admin_items_path
  click_link "Sample Item"
  click_link 'Edit'
  fill_in 'Title en', :with => 'New Title'
  click_button 'Update Item'
end

Then /^I should have an item titled "([^"]*)"$/ do |arg1|
  visit admin_items_path
  click_link arg1
  response.should contain(arg1)
  response.should contain("Publish: true")
end