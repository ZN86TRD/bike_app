class Admin::PostCommentsController < ApplicationController
    before_action :authenticate_admin!

    def destroy
        comment = PostComment.find(params[:id])
        post_id = comment.post_id
        comment.destroy
        flash[:notice] = "コメントを削除しました"
        redirect_to admin_post_path(post_id)
    end
end
