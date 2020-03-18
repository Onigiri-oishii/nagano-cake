class Admin::UsersController < ApplicationController
  def index
  end

  def show
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to admin_user_path(params[:id])
  	else
  		render "admin/users/edit"
  	end
  end


  private
  def user_params
  	params.require(:user).permit(:lastname, :ifirstname, :lastname_kana, :firstname_kana, :email, :postal, :address, :telephone, :password, :status)
  end
end
