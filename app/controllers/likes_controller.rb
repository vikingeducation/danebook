class LikesController < ApplicationController

  def create
    @like = Like.new({likeable_type: params[:likeable_type],likeable_id: params[:likeable_id], user_id: current_user.id})
    flash[:alert] = "You already liked this post, no need to do it again" unless @like.save
    redirect_to timeline_path
  end

  def destroy
    @like = Like.search_record(params[:likeable_type], params[:likeable_id], current_user.id)
    if @like
      @like.destroy
    else
      flash[:alert] = "You already unliked this post, no need to do it again"
    end
    redirect_to timeline_path
  end


end
