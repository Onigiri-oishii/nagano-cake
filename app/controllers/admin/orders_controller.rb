class Admin::OrdersController < ApplicationController
  def index
  	@order = Order.all
  end

  def update
  end

  def show
  end

end
