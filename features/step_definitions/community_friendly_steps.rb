Then /^I should have facebook meta tags$/ do
  response.should have_xpath("//meta[@property='og:title']")
  response.should have_xpath("//meta[@property='og:site_name']")
  response.should have_xpath("//meta[@property='og:image']")
  response.should have_xpath("//meta[@name='description']")
end
