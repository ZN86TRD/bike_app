class Admin::DashboardsController < ApplicationController
    before_action :authenticate_admin!
  
    def index
      @users_count = User.count
    @posts_count = Post.count
    @comments_count = PostComment.count
    @today_posts_count = Post.where(created_at: Time.zone.now.all_day).count
    end
  end