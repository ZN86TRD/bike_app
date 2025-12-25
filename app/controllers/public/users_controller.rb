class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit, :update, :confirm_withdraw, :destroy]

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to mypage_path, alert: 'ゲストログインでは実行できません。'
    end
  end

  def show
    @user = current_user
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to mypage_path, notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  def confirm_withdraw
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    reset_session
    redirect_to new_user_registration_path, notice: "退会処理が完了しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to mypage_path, alert: "ゲストログインでは実行できません。"
    end
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path
    end
  end
end
