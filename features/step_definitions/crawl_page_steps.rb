Given /^a URL$/ do
  @url = 'http://www.vamosa.com'
end

When /^a crawl site$/ do
  WebCrawler.crawl(@url)
end

Then /^I should have csv file containing URL, title and status code$/ do
  pending # express the regexp above with the code you wish you had
end