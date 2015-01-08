require 'nokogiri'
require 'open-uri'
require 'set'

module Scrapper
  class Fetch
    def self.fetch(url)
      Nokogiri::HTML(open(url))
    rescue
      false
    end
  end

  class Links
    attr_reader :links

    XPATH_PATTERN = '//a'

    def initialize(url)
      @url = url
      @links = Set.new
    end

    def find
      @doc = Fetch.fetch(url)

      if doc
        doc.xpath(XPATH_PATTERN).each do |link|
          href = link['href']
          links.add(fqdn(href)) if valid_href_segment(href)
        end
      end
    end

    private

    attr_reader :url, :doc

    def valid_href_segment(href)
      !href.nil? &&
        !href.empty? &&
        href != %r|^#| &&
        href != %r|http:\/\/mobile.| &&
        href != %r|http:\/\/m.|
    end

    def fqdn(href)
      href =~ /^http/ ? href : "#{url}/#{href}"
    end
  end
end
