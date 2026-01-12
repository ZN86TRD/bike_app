class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @groups = Group.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @genres = Genre.all
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    
    if @group.save
      GroupUser.create(user_id: current_user.id, group_id: @group.id, status: :approved)
      redirect_to group_path(@group), notice: "グループを作成しました"
    else
      @genres = Genre.all
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "グループ情報を更新しました"
    else
      @genres = Genre.all
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path, notice: "グループを削除しました。"
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :genre_id)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
