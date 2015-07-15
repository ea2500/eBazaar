class HomeController < ApplicationController
  def index
  	@products = Product.all.sample(10)
  end
end
