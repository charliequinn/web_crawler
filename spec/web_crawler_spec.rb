require 'spec_helper'

describe WebCrawler do
  it {WebCrawler.crawl('http://www.google.co.uk').should be true}
end