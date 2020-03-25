class UsersController < ApplicationController

  before_action :authenticate_user! , only:[:edit, :show, :confirm]

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
    if params[:status] == "false"
      @user.update_columns(status: false)
      sign_out_and_redirect(current_user)
    else
      if @user.update(user_params)
        sign_in(@user, :bypass => true)
        redirect_to user_path(@user.id)
      else
        render :edit
      end
    end
  end

  def confirm
  end

  private
  def user_params
  	params.require(:user).permit(:lastname, :firstname, :lastname_kana, :firstname_kana, :email, :postal, :address, :telephone, :password, :status)
  end
end

