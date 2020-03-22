class OrdersController < ApplicationController
  def new
    @order = Order.new
    @user = User.find(current_user.id)
    @receiver = Receiver.where(user_id: current_user.id)
  end

  def confirm
    @order = Order.new(order_params) #way(入金方法)をviewから受け取り
    @order.user_id = current_user.id

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

    #--------ユーザのカート内商品を@cart_productに格納--------
    @cart_products = CartProduct.where(user_id: current_user.id) 

    #--------total_products(商品合計金額)を求める--------
    total_pr = 0
    @cart_products.each do |c|
      total_pr = total_pr + Product.find(c.product_id).no_tax * c.number * 1.1
    end
    @order.total_products = total_pr

    #--------otal_pay(支払合計金額)を求める--------
    @order.total_pay = @order.total_products + 800

  end

  def create
  end

  def thanks
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:way)
  end

end
