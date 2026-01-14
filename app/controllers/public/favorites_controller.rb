class Public::FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

  def index
    favorite_post_ids = current_user.favorites.pluck(:post_id)
    @favorite_posts = Post.where(id: favorite_post_ids).order(created_at: :desc).page(params[:page]).per(10)
  end
end
