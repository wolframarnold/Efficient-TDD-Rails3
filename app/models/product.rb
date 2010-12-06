class Product
  require 'open-uri'

  BaseURL = "http://www.amazon.com/rss/tag/"

  attr_reader :title, :link, :description

  def initialize(feed_item)
    @title = feed_item.title
    @link = feed_item.link
    @description = feed_item.description
  end

  def self.fetch(tag='running')
    SimpleRSS.parse(open(BaseURL+tag+'/popular?length=5')).items.map {|i| Product.new(i) }
  end

  def image_url
    return @image_url unless @image_url.nil?
    xml_desc = Nokogiri::XML.parse(description)
    @image_url = xml_desc.css("img").first.attribute('src').value
  end

end