Given /^I have pages$/ do
  Fixtures.create_fixtures("test/fixtures", "pages")
  Fixtures.create_fixtures("test/fixtures", "page_translations")
end

Given /^I have no pages$/ do
  # do nothing since we don't want them to load
end
