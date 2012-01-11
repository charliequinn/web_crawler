require 'nokogiri'

class Page
  def self.index url, response
    html_doc = Nokogiri::HTML(response.body)
    {:result => "#{url},#{page_title(html_doc)},#{response.code}",
     :found_links => find_links(html_doc)}
  end

  private
  def self.page_title html_doc
    html_doc.css("title").text
  end

  def self.find_links html_doc
    links = []
    html_doc.css('a').each do |link|
      links << link['href'] if valid_link?(link['href'])
    end

    links
  end

  def self.valid_link? link
    !link.nil? && !(link == "#")
  end
end