class OrdersController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @order = current_user.orders.new
    @orders = current_user.orders.all
  end

  def confirm
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
  def receiver_params
    params.require(:order).permit(:user_id,:way,:address,:postal,:name,)
  end
end
