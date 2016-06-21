class PostsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :require_current_user, only: [:create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:users_liked)
  end

  def create
    @post = current_user.posts.build(whitelisted_params)
    if @post.save
      flash[:success] = "New post !"
      redirect_to (:back)
    else
      flash[:danger] = "Something wrong"
      redirect_to (:back)
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.delete
      flash[:success] = "Deleted!"
      redirect_to (:back)
    else
      flash[:danger] = "Not Deleted ?"
      redirect_to (:back)
    end
  end

  def whitelisted_params
    params.require(:post).permit(:body)
  end
end
