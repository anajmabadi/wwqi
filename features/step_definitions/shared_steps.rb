Given /^I speak English$/ do
  I18n.locale = :en
end

Given /^I speak Persian$/ do
    I18n.locale = :fa
end

Then /^I should have facebook meta tags$/ do
  page.should have_xpath("//meta[@property='og:title']")
  page.should have_xpath("//meta[@property='og:site_name']")
  page.should have_xpath("//meta[@property='og:image']")
  page.should have_xpath("//meta[@name='description']")
end

