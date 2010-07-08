Then /^I should have facebook meta tags$/ do
  page.should have_xpath("//meta[@property='og:title']")
  page.should have_xpath("//meta[@property='og:site_name']")
  page.should have_xpath("//meta[@property='og:image']")
  page.should have_xpath("//meta[@name='description']")
end

Then /^I should have sharethis buttons$/ do
  page.should have_xpath("//div[@class='addthis_toolbox addthis_default_style']")
end
