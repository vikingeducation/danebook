class LikesController < ApplicationController

  before_action :require_login, :only => [:create, :destroy]

  def create
    #refactor later into creating like through object association
    #but obj not passed in parameters
    session[:return_to] ||= request.referer
    like = Like.new(params_list)
    #find obj with params_list, then build

    like.user_id = current_user.id
    if like.save
      flash[:success] = "You have liked this!"
    else
      flash[:error] = "There was an error, please try liking again!"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer
    like = current_user.match_like(params_list)
    if current_user.id == like.user_id && like.destroy
      flash[:success] = "You have unliked this!"
    else
      flash[:error] = "There was an error, please try again!"
    end
    redirect_to session.delete(:return_to)
  end

  def show
    @likes = Like.recent_likes(extract_likings)
  end

  # def index
  #   @likes = extract_likings.likes

  # end

  private

  def params_list
      params.require(:like).permit(:likings_type, :likings_id, :method, :id)
  end

  # def extract_likings
  #   likings_type = request.referrer.split('/')[5]
  #   # resource, id = request.path.split('/')[1,2]
  #   likings_type.singularize.classify.constantize.find(likings_id)
  # end
end
