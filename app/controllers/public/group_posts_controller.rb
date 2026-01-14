class Public::GroupPostsController < ApplicationController

  def create
     @group = Group.find(params[:group_id])
     @group_post = current_user.group_posts.new(group_post_params)
     @group_post.group_id = @group.id
     @group_post.save
  end
    
  def destroy
     @group_post = GroupPost.find(params[:id])
     @group = @group_post.group
     @group_post.destroy
  end
    
  private
    
  def group_post_params
     params.require(:group_post).permit(:body)
  end
end
