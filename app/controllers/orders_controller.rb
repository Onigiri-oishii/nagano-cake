class OrdersController < ApplicationController
  def new
    @order = Order.new
    @user = User.find(current_user.id)
    @receiver = Receiver.where(user_id: current_user.id)
    @cart_products = current_user.cart_products.all
    if @cart_products.count < 1
      redirect_to user_cart_products_path(current_user)
      flash[:notice] = "※カートに商品を追加してください"
    end
  end

  def confirm
    @order = current_user.orders.new
    #--------ユーザのカート内商品を@cart_productに格納--------
    @cart_products = current_user.cart_products.all

    @order.way = params[:way] #way(入金方法)をviewから受け取り

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
      if params[:postal3] == "" || params[:address3] == "" || params[:name3] == ""
        redirect_to new_order_path
        flash[:notice] = "※お届け先を入力してください"
      else
        @order.postal = params[:postal3]
        @order.address = params[:address3]
        @order.name = params[:name3]
        @order.telephone = params[:telephone3]
        @receiver = current_user.receivers.new(postal: params[:postal3], address: params[:address3], name: params[:name3])
        @receiver.save
      end
    else #例外処理
      redirect_to root_path
    end
  end

  def create
    @cart_products = current_user.cart_products.all
    @order = current_user.orders.new(order_params)
    @order.save
    @cart_products.each do |cart_product|
      @order_product = OrderProduct.new
      @order_product.order_id = @order.id
      @order_product.product_id = cart_product.product_id
      @order_product.number = cart_product.number
      @order_product.price = (cart_product.product.no_tax * 1.1).floor
      @order_product.production_status = 0
      if @order_product.save
        @cart_products.destroy_all
      end
    end
    redirect_to orders_thanks_path
  end



  def thanks
  end

  def index
    @orders = current_user.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:fee, :total_products, :total_pay, :address, :postal, :telephone, :name, :way)
  end
end
