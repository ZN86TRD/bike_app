class Public::BikesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @bikes = @user.bikes
  end

  def show
    @user = User.find(params[:user_id])
    @bike = Bike.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @bike = Bike.new
  end

  def create
    @bike = current_user.bikes.new(bike_params)
    if @bike.save
      redirect_to user_bikes_path(current_user), notice: "ガレージに登録しました"
    else
      @user = current_user
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @bike = Bike.find(params[:id])
  end

  def update
    @bike = Bike.find(params[:id])
    if @bike.update(bike_params)
      redirect_to user_bikes_path(current_user), notice: "ガレージの情報を更新しました"
    else
      @user = current_user
      render :edit
    end
  end

  def destroy
    @bike = Bike.find(params[:id])
    @bike.destroy
    redirect_to user_bikes_path(current_user), notice: "削除が完了しました"
  end

  private

  def bike_params
    params.require(:bike).permit(:maker, :name, :bike_type, :component, :image)
  end

  def ensure_correct_user
    @user = User.find(params[:user_id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: "ログインユーザ以外が編集することはできません。"
    end
  end
end
