class CommentsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :require_comment_author, only: [:destroy]

  def create
    @type = params[:commentable]
    @id = get_commentable_id
    respond_to do |format|
      if @type.constantize.exists?(@id)
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.commentable_type = @type
        @comment.commentable_id = @id.to_i
        if @comment.save
          format.html {
            flash[:success] = "Comment created!"
            redirect_to :back
          }
          format.js {
            flash.now[:success] = "Comment created!"
          }
        else
          format.html {
            flash[:danger] = "Failed to create comment!"
            @user = current_user
            @current_post = Post.find(params[:post_id])
            @profile = @current_post.user.profile
            @posts = @current_post.user.posts.order("created_at DESC")
            render "users/show"
          }
          format.js {
            flash[:danger] = "Failed to create comment!"
            @user = current_user
            @current_post = Post.find(params[:post_id])
            @profile = @current_post.user.profile
            @posts = @current_post.user.posts.order("created_at DESC")
            render "users/show"
          }
        end
      else
        flash[:danger] = "That #{@type} Doesn't Exist!"
        redirect_to :back
      end
    end
  end

  def destroy
    @type = params[:commentable]
    @id = get_commentable_id
    respond_to do |format|
      if @type.constantize.exists?(@id)
        @c = Comment.find(params[:id])
        if @c.destroy
          format.html {
            flash[:success] = "Comment deleted!"
            redirect_to :back
          }
          format.js {
            flash.now[:success] = "Comment deleted!"
          }
        else
          format.html {
            flash[:danger] = "Failed to delete Comment!"
            redirect_to :back
          }
          format.js {
            flash[:danger] = "Failed to delete Comment!"
            redirect_to :back
          }
        end
      else
        flash[:danger] = "That #{@type} Doesn't Exist!"
        redirect_to :back
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  # def get_comment
  #   comments = @type.constantize.find(@id).comments
  #   comment = comments.select { |l| l.user_id == current_user.id }
  #   return comment[0]
  # end

  def get_commentable_id
    class_name = params[:commentable]
    class_id = (class_name.downcase + "_id").to_sym
    params[class_id]
  end

  def require_comment_author
    commenty = Comment.find_by_id(params[:id])
    unless commenty && commenty.user_id == current_user.id
      flash[:danger] = "Not authorized! This isn't your Comment!"
      redirect_to user_path(current_user)
    end
  end
end
