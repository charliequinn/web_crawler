require 'spec_helper'

describe WebCrawler do
  describe "crawl" do
    before do
      stub_requests
      @expected_contents =
<<STRING
http://www.example.com,Home,200
http://www.example.com/help,Help,200
http://www.example.com/pies?type=steak and kidney,Pies,200
http://www.example.com/sweets,,404
STRING
    end

    it "should create file with all results" do
      WebCrawler.new.crawl("http://www.example.com", "./results.txt")
      file = File.open("./results.txt", 'rb')
      file.read.should eql @expected_contents
    end
  end
end

def stub_requests
  stub_request(:get, "http://www.example.com").to_return(:body => '<html><head><title>Home</title></head><body><a href="/help"/></body></html>', :status => 200)
  stub_request(:get, "http://www.example.com/help").to_return(:body => '<html><head><title>Help</title></head><body><a href="www.pieshop.com"/><a href="www.example.com/pies?type=steak and kidney"/><a href="www.pieshop.com" /></body></html>', :status => 200)
  stub_request(:get, "http://www.example.com/pies?type=steak%20and%20kidney").to_return(:body => '<html><head><title>Pies</title></head><body><a href="www.example.com/sweets"/></body></html>', :status => 200)
  stub_request(:get, "http://www.example.com/sweets").to_return(:body => '', :status => 404)
end