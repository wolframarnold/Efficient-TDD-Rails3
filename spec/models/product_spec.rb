require 'spec_helper'

describe Product do
  before :all do
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:get, Product::BaseURL + 'running' + "/popular?length=5", :body => File.open(File.join(Rails.root,'spec','fixtures','products_rss.xml')).read)
  end

  context '#fetch' do
    it 'retrieves RSS feed' do
      lambda {
        Product.fetch
      }.should_not raise_error
    end
    it 'returns an array of products for given tag' do
      FakeWeb.register_uri(:get, Product::BaseURL + 'swimming' + "/popular?length=5", :body => File.open(File.join(Rails.root,'spec','fixtures','products_rss.xml')).read)
      prods = Product.fetch("swimming")
      prods.should be_kind_of(Array)
      prods.each do |p|
        p.should be_kind_of(Product)
      end
    end
  end

  it 'can be instantiated with a feed item having :title, :link, :description methods' do
    feed_item = mock("FeedItem", :title => "Running Shoes", :link => "http://example.com/running_shoes", :description => "They're great")
    p = Product.new(feed_item)
    p.should respond_to(:title)
    p.should respond_to(:link)
    p.should respond_to(:description)
    p.title.should == "Running Shoes"
    p.link.should == "http://example.com/running_shoes"
    p.description.should == "They're great"
  end

  it 'extracts the first image url and returns it in #image_url' do
    p = Product.fetch.first
    p.should respond_to(:image_url)
    p.image_url.should == 'http://ecx.images-amazon.com/images/I/51lHg9ZcN7L._SL160_SS160_.jpg'
  end
end