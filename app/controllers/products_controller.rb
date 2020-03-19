class ProductsController < ApplicationController
  def index
  end

  def show
  	@genres = Genres.all
  	@product = Product.find(params[:id])
  	@user = current_user
  	@cart_product = @user.cart_product.new
  end
end
