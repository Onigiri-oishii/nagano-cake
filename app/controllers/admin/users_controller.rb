class Admin::UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  private
  def user_params
    params.require(:user).permit(:lastname, :firstname, :lastname_kana, :firstname_kana, :email, :postal, :address, :telephone, :password, :status)
  end

end
