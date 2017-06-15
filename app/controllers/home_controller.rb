class HomeController < ApplicationController
  def index
    @products = Product.find_public_products
  end

  def show
  end

  def authentication
  end
end
