require 'spec_helper'

class DummyResponse
  attr_accessor :body, :code

  def initialize(code, body)
    @code = code
    @body = body
  end
end

describe Page do
  it "should return hash containing index result and crawl_frontier of page" do
    @url = "www.blah.com"
    @response = DummyResponse.new(200, "<html><head><title>Hello EmergeAdapt</title></head>
                                        <body><a href=\"www.here.com\"><a href=\"/anywhere\">
                                        <a href=\"\#\" />
                                        <a href=\"www.here.com/?pies=steak\">
                                        <a href=\"http://www.google.co.uk\" />
                                        </body>")

    Page.index(@url, @response).should eql({:result => "#{@url},Hello EmergeAdapt,200", :found_links => ["www.here.com",
                                                                                                         "/anywhere",
                                                                                                         "www.here.com/?pies=steak",
                                                                                                         "http://www.google.co.uk"]})
  end
end