class CommentsController < ApplicationController

  before_action :require_login, :only => [:create]
  before_action :require_current_user, :only => [:destroy]


  def create
    @new_comment = current_user.comments.build(comment_params)

    if @new_comment.save
      Comment.delay.send_notification(@new_comment.id)
      flash[:success] = "Comment created!"

      respond_to do |format|
        format.html { redirect_back_or_to(user_posts_path(@new_comment.commentable.poster)) }
        format.js { render :create_success, :status => 200 }
      end

    else
      flash[:danger] = "Comment not saved. Please try again."

      respond_to do |format|
        format.html { redirect_back_or_to(user_posts_path(@new_comment.commentable.poster)) }
        format.js { render 'shared/action_failure', :status => 400 }
      end
    end

  end


  def destroy
    @comment = Comment.find(params[:id])
    @id = @comment.id
    @parent_poster = @comment.commentable.poster

    if @comment.destroy!
      flash[:success] = 'Comment deleted!'

      respond_to do |format|
        format.html { redirect_to user_posts_path(@parent_poster) }
        format.js { render :destroy_success, :status => 200 }
      end

    else
      flash[:danger] = "Sorry, we couldn't delete your comment. Please try again."

      respond_to do |format|
        format.html { redirect_to user_posts_path(@parent_poster) }
        format.js { render 'shared/action_failure', :status => 400 }
      end
    end
  end


  private


    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end


    def require_current_user
      comment = Comment.find(params[:id])
      unless comment.author == current_user
        flash[:danger] = "You're not authorized to do this!"
        redirect_to user_posts_path(comment.commentable.poster)
      end
    end

end
