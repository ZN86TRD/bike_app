class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # is_active を falseに
    if @user.update(is_active: false)
      flash[:notice] = "ユーザーを退会処理しました。"
      redirect_to admin_user_path(@user)
    else
      flash[:alert] = "退会処理に失敗しました。"
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_active) 
  end
end
