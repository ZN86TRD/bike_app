class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @post = Post.new
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿に成功しました！"
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)
      render :index 
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  def map
    # 緯度・経度が入力された投稿だけを取得
    @posts = Post.where.not(latitude: nil).where.not(longitude: nil)
  end

  private

  def post_params
    params.require(:post).permit(:address, :title, :body, :image)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path, alert: "他人の投稿です。"
    end
  end
end
