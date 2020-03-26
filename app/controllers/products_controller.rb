class ProductsController < ApplicationController

  def index
    @genres = Genre.where(status: true)
    @product_count = Product.all.count
    if params[:search]
      @products = Product.where(products_search_params).page(params[:page]).per(8)
      @genreid = params[:genres_id_var]
    else
      @products = Product.where(genre_status: true).page(params[:page]).per(8)
    end
  end

  def show
  	@genres = Genre.all
  	@product = Product.find(params[:id])
  	@user = current_user
    redirect_to products_path if Genre.find(@product.genres_id).status == false
    if user_signed_in?
  	 @cart_product = @user.cart_products.new
    end

  end

  private
  def products_search_params
    params.fetch(:search, {}).permit(:genres_id)
  end
end

