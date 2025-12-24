class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to mypage_path, alert: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
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

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path
    end
  end
end
