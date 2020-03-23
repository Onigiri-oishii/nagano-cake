class Admin::OrdersController < ApplicationController
  def index
  end

  def update
  	case params[:switch_status]
  	when "1" then
  		@order = Order.find(params[:id])
  		@order.update_columns(order_status: params[:send_order_status])
  	when "2" then
  		@order_product = OrderProduct.find(params[:send_production_id])
  		@order_product.update_columns(production_status: params[:send_production_status])
  	else
  		redirect_to admin_order_path(params[:id])
  	end
  	redirect_to admin_order_path(params[:id])
  end

  def show
  	@order = Order.find(params[:id])
  	@order_products = OrderProduct.where(order_id: @order.id) #注文内のorder_productのみ取り出し
  end

end
