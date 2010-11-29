class ProductsController < ApplicationController

  def index
    @products = Product.fetch
  end

end
