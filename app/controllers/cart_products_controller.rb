class CartProductsController < ApplicationController
  def index
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
    @cart_product = current_user.cart_products.new(cart_product_params)
    if @cart_product.save
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
