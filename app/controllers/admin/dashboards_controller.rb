class Admin::DashboardsController < ApplicationController
    before_action :authenticate_admin!
  
    def index
      @users_count = User.count
      @posts_count = Post.count
      @comments_count = PostComment.count
      @today_posts_count = Post.where(created_at: Time.zone.now.all_day).count

      @post_counts_by_day = Post.where(created_at: 6.days.ago.beginning_of_day..Time.zone.now.end_of_day).group("DATE(created_at)").count.transform_keys(&:to_s)
    end
  end