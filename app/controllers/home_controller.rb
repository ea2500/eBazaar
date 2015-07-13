class HomeController < ApplicationController
  def index
  	@ps=Product.all.sample(10)
  end
end
