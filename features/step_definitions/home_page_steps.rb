Given /^I have these subject types:$/ do |table|
  # table is a Cucumber::Ast::Table
  @subject_types = table.hashes
end    

Then /^I should have valid subject type archive links$/ do
  @subject_types.each do |subject_type|
    click_link(subject_type[:name])
    page_name = "/archive/subject_type_filter/#{subject_type[:id]}"
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == page_name
    else
      assert_equal page_name, current_path
    end
    click_link("Women's Worlds in Qajar Iran")
  end
end
