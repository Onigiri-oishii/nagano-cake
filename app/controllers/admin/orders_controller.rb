class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin! , only:[:index, :show]

  def index
    if params[:page_select] == "1" then
      @orders = Order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(created_at: :desc).page(params[:page]).per(10)
      @title = "#{Date.today}の注文一覧"
    elsif params[:page_select] == "2" then
      @orders = Order.all.order(created_at: :desc).page(params[:page]).per(10)
      @title = "注文一覧"
    elsif params[:page_select] == "3" then
      @orders = Order.where(user_id: params[:user_select]).order(created_at: :desc).page(params[:page]).per(10)
      @user = User.find_by(id: params[:user_select])
      @title = "#{@user.lastname + @user.firstname} 様の注文一覧"
    elsif params[:page_select] == "4" then
      @orders = Order.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).order(created_at: :desc).page(params[:page]).per(10)
      @title = "#{Date.today.month}月の注文一覧"
    else
    end
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
