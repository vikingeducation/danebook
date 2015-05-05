class PostsController < ApplicationController

  before_action :require_current_user, except: [:index]
  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends.shuffle
    @posts = @user.posts_chronologically

    # you only need a new post form if you're on your own timeline
    @post = current_user.posts.build if @user == current_user
  end

  def show
    redirect_to user_timeline_path(params[:user_id])
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_url(current_user) }
        format.js { render :create }
      else
        flash[:error] = "Failed to post."
        format.html { render :index }
        # format.js { render unprocessable object }
      end
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted."
      redirect_to user_posts_url(current_user)
    else
      flash[:error] = "Something went wrong with this deletion."
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
