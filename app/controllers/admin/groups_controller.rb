class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.order(created_at: :desc).page(params[:page]).per(10)
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      redirect_to admin_groups_path, notice: "グループ名:「#{@group.name}」を削除しました。"
    else
      redirect_to admin_groups_path, alert: "削除に失敗しました。"
    end
  end
end
