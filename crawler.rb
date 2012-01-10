#!/usr/bin/env ruby

require './lib/web_crawler'
require './lib/page'

site = ARGV[0]

site = "http://#{site}" if !site.match(/^http:\/\//)

WebCrawler.new.crawl(site, ARGV[1])



