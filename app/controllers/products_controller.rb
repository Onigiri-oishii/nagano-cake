class ProductsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:search]
      @products = Product.where(products_search_params).page(params[:page]).per(6)
    else
      @products = Product.all.page(params[:page]).per(6)
    end
  end

  def show
  	@genres = Genre.all
  	@product = Product.find(params[:id])
  	@user = current_user
  	@cart_product = @user.cart_products.new
  end

  private
  def products_search_params
    params.fetch(:search, {}).permit(:genres_id)
  end
end


