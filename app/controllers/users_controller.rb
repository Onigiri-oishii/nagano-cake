class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	unless @user.id == current_user.id
  		redirect_to user_path(current_user)
  	end
  end

  def edit
  	@user = User.find(params[:id])
  	if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      sign_in(@user, :bypass => true)
      if @user.status == false
        redirect_to root_path
      else
        redirect_to user_path(@user.id)
      end
    else
      render :edit
    end
  end

  def confirm
  end

  private
  def user_params
    params.require(:user).permit(:lastname, :ifirstname, :lastname_kana, :firstname_kana, :email, :postal, :address, :telephone, :password, :status)
  end
end