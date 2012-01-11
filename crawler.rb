#!/usr/bin/env ruby
require './lib/web_crawler'
require './lib/page'

site = ARGV[0].dup
file = ARGV[1].dup

results = WebCrawler.new(ARGV[0].dup).crawl
results.each do |result|
  File.open(local_filename, 'w') {|f| f.write(doc) }  .
end



