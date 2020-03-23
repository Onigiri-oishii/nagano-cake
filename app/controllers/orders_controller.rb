class OrdersController < ApplicationController
  def new
    @order = Order.new
    @user = User.find(current_user.id)
    @receiver = Receiver.where(user_id: current_user.id)
  end

  def confirm
    @order = current_user.orders.new
    @order.order_products.build

    @order.way = params[:way] #way(入金方法)をviewから受け取り
    #--------ユーザのカート内商品を@cart_productに格納--------
    @cart_products = current_user.cart_products.all

    #--------radio_buttonの選択に応じた住所を登録する--------
    selected_address = "" #変数宣言：orderに格納する住所
    case params[:receiver_type] #radioボタンの選択箇所「1 or 2 or 3」で処理選択
    when "1" then
      @order.postal = params[:postal1]
      @order.address = params[:address1]
      @order.name = params[:name1]
      @order.telephone = params[:telephone1]
    when "2" then
      @receiver_select = Receiver.find(params[:full_address_id])
      @order.postal = @receiver_select.postal
      @order.address = @receiver_select.address
      @order.name = @receiver_select.name
      @order.telephone = params[:telephone2]
    when "3" then
      @order.postal = params[:postal3]
      @order.address = params[:address3]
      @order.name = params[:name3]
      @order.telephone = params[:telephone3]
    else #例外処理
      redirect_to new_order_path
    end
  end

  def create
    @cart_products = current_user.cart_products.all
    @order = current_user.orders.new(order_params)
    if @order.save
      @cart_products.destroy_all
      redirect_to orders_thanks_path
    end
  end

  def thanks
  end

  def index
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:fee, :total_products, :total_pay, :address, :postal, :telephone, :name, :way, order_products_attributes: [:product_id, :production_status, :number, :price])
  end
end
