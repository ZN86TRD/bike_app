class Public::EventNoticesController < ApplicationController
    before_action :authenticate_user!

  def new
    @group = Group.find(params[:group_id])
    unless @group.owner_id == current_user.id
      redirect_to group_path(@group), alert: "オーナーのみ送信可能です"
    end
  end

  def create
    @group = Group.find(params[:group_id])
    @title = params[:title]
    @body = params[:body]
    
    # バリデーション：タイトルまたは本文が空の場合
    if @title.blank? || @body.blank?
        flash.now[:alert] = "タイトルと本文は必須項目です。"
        render :new
        return # 送信中断
    end

    # グループメンバー全員(確認のため自身含む)
    @members = @group.users 

    @members.each do |member|
      ContactMailer.send_notification(member, @title, @body).deliver_now
    end

    render :sent # 送信完了画面
  end
end
