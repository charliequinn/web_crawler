require 'spec_helper'

describe WebCrawler do
  describe "crawl" do
    before do
      @initial_page = {:url => "http://www.example.com", :title => 'Home', :links => ["/help", "/sweets", "/gold"], :status => 200}
      @external_links_page = {:url => "http://www.example.com/help", :title => 'Help', :links => ["www.pieshop.com", "www.piesrus.com"], :status => 200}
      @parameterised_links_page = {:url => "http://www.example.com/sweets", :title => 'Sweets', :links => ["www.example.com/pies?type=steak and kidney"], :status => 200}
      @relative_links_page = {:url => "http://www.example.com/gold", :title => 'gold', :links => ["/ties"], :status => 200}
      @already_visited_links_page = {:url => "http://www.example.com/ties", :title => 'ties', :links => ["www.example.com/gold"], :status => 200}
      @not_found_page = {:url => "www.example.com/pies", :links => [], :status => 404}

      stub_requests
    end

    it "should create file with expected_contents" do
      web_crawler = WebCrawler.new("http://www.example.com")
      web_crawler.crawl.should eql ["http://www.example.com,Home,200",
                                    "http://www.example.com/help,Help,200",
                                    "http://www.example.com/sweets,Sweets,200",
                                    "http://www.example.com/gold,gold,200",
                                    "http://www.example.com/pies,,404",
                                    "http://www.example.com/ties,ties,200"]
    end
  end
end


def stub_requests
  [@initial_page,
   @external_links_page,
   @parameterised_links_page,
   @already_visited_links_page,
   @relative_links_page,
   @not_found_page].each do |page|
    stub_request(:get, page[:url]).
        to_return(:body => create_html(page[:title], page[:links]),
                  :status => page[:status])
  end
end

def create_html(title, links)
  html = "<html><head><title>#{title}</title></head><body>"
  links.each { |link| html += "<a href=\"#{link}\"/>" }
  html += "</body>/html>"
end