class Admin::PostsController < ApplicationController
    before_action :authenticate_admin!

    def show
        @post = Post.find(params[:id])
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        flash[:notice] = "投稿を削除しました"
        redirect_to admin_users_path # あるいは特定の遷移先へ
    end
end
