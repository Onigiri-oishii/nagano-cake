class ProductsController < ApplicationController

  def index
    @genres = Genre.where(status: true)
    #@genres = Genre.all
    if params[:search]
      @products = Product.where(products_search_params).page(params[:page]).per(6)
      @genreid = params[:genres_id_var]
    else
      #----------Product内でgenreが有効なもの　かつ　ページネーション----------
      # byebug
      # @propro = Genres.products.where(status: true)
      # productbuf = Product.all
      # product_buf_search = Product.new
      # productbuf.each do |p|
      #   if Genre.find(p.genres_id).status == true
      #     product_buf_search = product_buf_search + p
      #     product_buf_search.where
      #   end
      # end
      #@products = Product.where(.status == true).page(params[:page]).per(6)


     # @pro = Product.where(status: true).page(params[:page]).per(6)

      @products = Product.where(genre_status: true).page(params[:page]).per(6)
      byebug
    end
  end

  def show
  	@genres = Genre.all
  	@product = Product.find(params[:id])
  	@user = current_user
    if user_signed_in?
  	 @cart_product = @user.cart_products.new
    end
  end

  private
  def products_search_params
    params.fetch(:search, {}).permit(:genres_id)
  end
end

