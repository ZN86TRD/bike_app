class Public::HomesController < ApplicationController

  def top
    if user_signed_in?

      @posts = Post.feed(current_user).page(params[:page]).per(5) 
    else
  
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(5)
    end
  end

  def about
  end
end
