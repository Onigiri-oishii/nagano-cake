class OrdersController < ApplicationController
  def new
  end

  def confirm
    @cart_products = current_user.cart_products.all
    @order = Order.new
    @order.order_products.build
  end

  def create
    @cart_products = current_user.cart_products.all
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    if @order.save
      @cart_products.detroy_all
      redirect_to orders_thanks_path
    end
  end

  def thanks
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:fee, :total_products, :total_pay, :address, :postal, :telephone, :name, order_products_attributes: [:production_status, :number, :price])
  end
end
