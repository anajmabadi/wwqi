Given /^I have subject types$/ do
  Fixtures.create_fixtures("test/fixtures", "subject_types")
  Fixtures.create_fixtures("test/fixtures", "subject_type_translations")
end

Given /^I have periods$/ do
  Fixtures.create_fixtures("test/fixtures", "periods")
  Fixtures.create_fixtures("test/fixtures", "period_translations")
end

Given /^I have items$/ do
  Fixtures.create_fixtures("test/fixtures", "items")
  Fixtures.create_fixtures("test/fixtures", "item_translations")
end

Given /^I have collections$/ do
  Fixtures.create_fixtures("test/fixtures", "collections")
  Fixtures.create_fixtures("test/fixtures", "collection_translations")
end

Given /^I have activities$/ do
  Fixtures.create_fixtures("test/fixtures", "activities")
end

Given /^I have these periods:$/ do |table|
  # table is a Cucumber::Ast::Table
  @periods = table.hashes
end


Then /^I should have valid subject type archive links from archive$/ do
  @subject_types.each do |subject_type|
    click_link(subject_type[:name])
    page_name = "/archive/browser"
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == page_name
    else
      assert_equal page_name, current_path
    end
    #controller.instance_variable_get('@subject_type_filter').should eq(subject_type[:id])
    click_link("archive")
  end
end

Then /^I should have valid period archive links$/ do
  @periods.each do |period|
    click_link(period[:name])
    page_name = "/archive/browser"
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == page_name
    else
      assert_equal page_name, current_path
    end
    #@period_filter.should == period[:id]
    click_link("archive")
  end
end