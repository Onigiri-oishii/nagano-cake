class ProductsController < ApplicationController
  def index
    if params[:genres_id]
    # genres_idと紐づく商品を取得
    @products = Product.where(:genre_id).all
    else
    # 商品をすべてを取得
    @products = Product.all
    end
    @genres = Genre.all
  end

  def show
  	@genres = Genres.all
  	@product = Product.find(params[:id])
  	@user = current_user
  	@cart_product = @user.cart_product.new
  end

end


