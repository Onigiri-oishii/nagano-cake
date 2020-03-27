class Admin::HomeController < ApplicationController

	before_action :authenticate_admin! , only:[:top]

  def top
  	@daily_orders = Order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  	@monthly_orders = Order.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
  end
end