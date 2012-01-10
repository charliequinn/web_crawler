require 'nokogiri'

class Page
  def self.index url, response
    {:result => "#{url},#{page_title(response.body)},#{response.code}",
     :crawl_frontier => find_links(url, response.body)}
  end

  private
  def self.page_title html
    html_doc = Nokogiri::HTML(html)
    html_doc.css("title").text
  end

  def self.find_links url, html
    html_doc = Nokogiri::HTML(html)
    links = []
    html_doc.css('a').each do |link|
      links << create_link(link['href'], url) if valid_link?(link['href'])
    end

    links
  end

  def self.create_link(link, url)
    link.strip!
    link = link.match(/^\//) ? url + link : link
    if !link.match(/^http:\/\//)
      link = "http://" + link
    end
    link
  end

  def self.valid_link?(link)
    !link.nil? && !(link == "#")
  end
end