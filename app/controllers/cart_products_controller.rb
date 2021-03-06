class CartProductsController < ApplicationController

  before_action :authenticate_user! , only:[:index]

  def index
    @user = current_user
    @cart_products = current_user.cart_products.all
  end

  def update
    @cart_product = current_user.cart_products.find(params[:id])
    if @cart_product.update(cart_product_params)
      redirect_to user_cart_products_path
    else
      redirect_to user_cart_products_path
      flash[:notice] = "※1以上の個数を選択してください"
    end
  end

  def destroy
    @cart_product = current_user.cart_products.find(params[:id])
    @cart_product.destroy
    redirect_to user_cart_products_path
  end

  def destroy_all
    @cart_products = current_user.cart_products.all
    @cart_products.destroy_all
    redirect_to user_cart_products_path
  end

  def create
    @new_cart_product = current_user.cart_products.new(cart_product_params)
    if @cart_product = current_user.cart_products.find_by(product_id: @new_cart_product.product_id)
      @cart_product.number += @new_cart_product.number
      @cart_product.update_columns(number: @cart_product.number)
      redirect_to user_cart_products_path(current_user)
    elsif @new_cart_product.save
      redirect_to user_cart_products_path(current_user)
    else
      render 'products/show'
    end
  end

  private
  def cart_product_params
    params.require(:cart_product).permit(:number, :product_id)
  end
end
