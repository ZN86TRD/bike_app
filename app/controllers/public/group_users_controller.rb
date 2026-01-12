class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    group = Group.find(params[:group_id])
    @group_user = current_user.group_users.new(group_id: group.id)
    if @group_user.save
      redirect_back(fallback_location: root_path, notice: "参加申請を送りました。")
    end
  end

  def update
    @group_user = GroupUser.find(params[:id])
    if @group_user.update(status: :approved)
      redirect_back(fallback_location: root_path, notice: "参加を承認しました。")
    end
  end

  def destroy
    @group_user = GroupUser.find(params[:id])
    @group_user.destroy
    redirect_back(fallback_location: root_path, notice: "グループから退会しました。")
  end
end
