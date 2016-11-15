class PostsController < ApplicationController
  before_action :require_current_user

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created'
    else
      flash[:error] = 'Post not created: ' +
        @post.errors.full_messages.join(', ')
    end
    redirect_to_referer user_activity_path(current_user)
  end

  def destroy
    @post = current_user.posts.find_by_id(params[:id])
    if @post && @post.destroy
      flash[:success] = 'Post destroyed'
    else
      flash[:error] = 'Post not destroyed'
    end
    redirect_to user_activity_path(current_user)
  end


  private
  def post_params
    params.require(:post)
      .permit(
        :body,
        :user_id
      )
  end
end
