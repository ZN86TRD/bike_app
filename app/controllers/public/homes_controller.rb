class Public::HomesController < ApplicationController

  def top
    if user_signed_in?
      # ログイン中は、フォロー中のユーザー新着投稿10件
      @posts = Post.feed(current_user).limit(10) 
    else
      # 未ログイン時は新着順に5件
      @posts = Post.all.order(created_at: :desc).limit(5)
    end
  end

  def about
  end
end
