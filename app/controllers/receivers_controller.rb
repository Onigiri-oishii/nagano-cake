class ReceiversController < ApplicationController

  before_action :authenticate_user! , only:[:index, :edit]

  def index
    @user = User.find(params[:user_id])
    @receiver = current_user.receivers.new
    @receivers = current_user.receivers.all
  end

  def create
    @receiver = current_user.receivers.new(receiver_params)
    if @receiver.save
      redirect_to user_receivers_path
    else
      @user = User.find(params[:user_id])
      @receivers = current_user.receivers.all
      render 'index'
    end
  end

  def destroy
    @receiver = current_user.receivers.find(params[:id])
    @receiver.destroy
    redirect_to user_receivers_path
  end

  def edit
    @user = User.find(params[:user_id])
    @receiver = current_user.receivers.find(params[:id])
  end

  def update
    @receiver = current_user.receivers.find(params[:id])
    if @receiver.update(receiver_params)
      redirect_to user_receivers_path
    else
      @user = User.find(params[:user_id])
      render 'edit'
    end
  end

  private
  def receiver_params
    params.require(:receiver).permit(:postal, :address, :name)
  end
end
