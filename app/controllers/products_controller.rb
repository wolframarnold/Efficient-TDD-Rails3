class ProductsController < ApplicationController
  def index
    @products = Feedzirra::Feed.fetch_and_parse("http://www.amazon.com/rss/tag/running/popular?length=5").entries
  end

end
