Given /^I speak English$/ do
  I18n.locale = :en
end

Given /^I speak Persian$/ do
    I18n.locale = :fa
end

Then /^"([^\"]*)" should link to "([^\"]*)"$/ do |link, url|
  xpath("//a[contains(.,'#{link}')]").first['href'].should == url
end