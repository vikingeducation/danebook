class PostsController < ApplicationController
  before_action :find_user
  before_action :require_current_user, only: [:create, :destroy]

  def index
    @new_post = Post.new(author: @user)

    # The session is stored here to properly bring the user to the
    # correct page. If they post from the newsfeed, they'll go back to the
    # newsfeed. Otherwise, they go to their own posts index.
    session[:newsfeed] = params[:newsfeed] || session[:newsfeed] || "false"
    if session[:newsfeed] == "true" && current_user && current_user == @user
      @recent = @user.recent_active_friends
      @posts = @user.newsfeed
      render :newsfeed
    else
      @posts = @user.get_posts
      render :index
    end
  end

  def create
    @post = Post.new(whitelist_post_params)
    if @post.save
      flash[:success] = "Successfully posted to your timeline!"
    else
      flash[:notice] = "Couldn't post to your timeline..."
    end
    redirect_to user_posts_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user.id == params[:user_id]
      if @post.destroy
        flash[:success] = "Post deleted Successfully!"
      else
        flash[:notice] = "Couldn't delete post, try again."
      end
    else
      flash[:notice] = "Cannot delete other user's posts."
    end
    redirect_to user_posts_path(current_user)
  end


  private
    def find_user
      @user = User.includes(:profile, friends: :profile_photo).find(params[:user_id])
    end

    def whitelist_post_params
      params.require(:post).permit(:user_id, :body)
    end
end
