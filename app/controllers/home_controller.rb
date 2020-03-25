class HomeController < ApplicationController
  def top
  	@genres = Genre.all
  	@products = Product.all
  	#5件表示
	@random = Product.order("RANDOM()").limit(4)
  end

  def about
  end
end
