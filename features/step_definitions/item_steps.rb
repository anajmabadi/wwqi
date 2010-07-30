Given /^I have an item titled "([^"]*)"$/ do |arg1|
  @item = Item.create!(:title => arg1, :pages => 1, :accession_num => "abcdefg")
end
