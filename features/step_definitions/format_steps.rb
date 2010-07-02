Given /^the following formats:$/ do |formats|
  Format.create!(formats.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) format$/ do |pos|
  visit formats_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following formats:$/ do |expected_formats_table|
  expected_formats_table.diff!(tableish('table tr', 'td,th'))
end
