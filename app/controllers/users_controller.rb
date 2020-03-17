class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	unless @user.id == current_user.id
  		redirect_to user_path(current_user)
  	end
  end

  def edit
  end

  def update
  end

  def confirm
  end
end
