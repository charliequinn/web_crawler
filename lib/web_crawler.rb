require 'net/http'

class WebCrawler
  def initialize site
    @site = create_url("", site)
    @crawl_frontier = []
  end

  def crawl
    @crawl_frontier = [@site]
    results = []

    @crawl_frontier.each do |url|
      page = index_page(url)
      results << page[:result]
      update_crawl_frontier(page[:found_links])
    end

    results
  end

  private
  def update_crawl_frontier links
    links.each do |link|
      url = create_url(@site, link)
      @crawl_frontier.push(url) if !@crawl_frontier.include?(url) && part_of_site?(url)
    end
  end

  def part_of_site?(link)
    link.match(/^\//) || link.match(/^#{@site}/)
  end

  def index_page(url)
    response = Net::HTTP.get_response(URI(URI::encode(url)))
    Page.index(url, response)
  end

  def create_url(site, link)
    link.strip!
    link = link[0..link.index('?')-1] if link.include? '?'

    link = link.match(/^\//) ? site + link : link
    if !link.match(/^http:\/\//)
      link = "http://" + link
    end

    link = link[0..-2] if link.match(/\/$/)
    link
  end
end
