class ProductsController < ApplicationController

  def index
    if params[:tag].present?
      @products = Product.fetch(params[:tag])
    else
      head 404
    end
  end

end
