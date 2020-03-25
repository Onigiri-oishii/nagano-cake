class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin! , only:[:index, :show]

  def index
  	@order = Order.all.page(params[:page]).per(10)
  end

  def update
  	case params[:switch_status]
  	when "1" then
  		@order = Order.find(params[:id])
  		case @order.update_columns(order_status: params[:send_order_status])
      when params[:send_order_status] == "入金確認" then
        @order_products = OrderProduct.where(order_id: @order.id)
        @order_products.each do |order_product|
          order_product.update_columns(production_status: "製作待ち")
        end
      end
  	when "2" then
  		@order_product = OrderProduct.find(params[:send_production_id])
  		case @order_product.update_columns(production_status: params[:send_production_status])
      when params[:send_production_status] == "製作中" then
        @order = Order.find(params[:id])
        @order.update_columns(order_status: "製作中")
      when params[:send_production_status] == "製作完了" then
        @order_products = OrderProduct.where(order_id: params[:id])
        flag = 0
        @order_products.each do |order_product|
          unless order_product.production_status == "製作完了"
            flag = 1
          end
        end
        if flag == 0
          @order = Order.find(params[:id])
          @order.update_columns(order_status: "発送準備中")
        end
      end
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
