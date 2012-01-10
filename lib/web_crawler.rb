require 'net/http'

class WebCrawler
  def crawl site, file_name
    crawl_frontier = [site]

    File.open(file_name, "w+") do |file|
      crawl_frontier.each do |url|
        page = index_page(url)
        file.puts(page[:result])
        page[:crawl_frontier].each do |url|
          crawl_frontier.push(url) if !crawl_frontier.include?(url) && url.match(/^#{site}/)
        end
      end
      file
    end
  end

  private
  def index_page(url)
    response = Net::HTTP.get_response(URI(URI::encode(url)))
    Page.index(url, response)
  end

  module FileWrite
    def self.write_to_file

    end
  end
end