#!/usr/bin/env ruby
require './lib/web_crawler'
require './lib/page'

site = ARGV[0].dup
file = ARGV[1].dup

puts "Starting crawl. Be patient :)"
results = WebCrawler.new(site).crawl

puts "Outputting results to file..."
File.open(file, 'w') do |f|
  results.each do |result|
    f.puts(result)
  end
end




