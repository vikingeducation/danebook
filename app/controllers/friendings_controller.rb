class FriendingsController < ApplicationController
  layout "friends"

  before_action :require_login, except: [:index]


  def index
    @user = User.find(params[:user_id])
    @friended_users = User.find(params[:user_id]).friended_users
    @users_friended_by = User.find(params[:user_id]).users_friended_by
  end


  def create
    @friender = current_user
    @friending_recipient = User.find(params[:user_id])

    # friendship already exists
    unless @friender.friended_users.include? @friend
      if current_user.friended_users << @friending_recipient
        flash[:success] = "You are now friends with #{@friending_recipient.first_name}"
      else
        flash[:error] = "Failed to friend! Forever alone :("
      end
    else
      flash[:error] = "You have already friend requested that person."
    end
    redirect_to :back
  end    



  def destroy
    unfriended_user = User.find(params[:id])
    if current_user.friended_users.delete(unfriended_user)
      flash[:success] = "You are no longer friends."
    else
      flash[:error] = "Oops, you are still friends."
    end
    redirect_to :back
  end


  private
  def whitelisted_params
    params.permit(:friender_id, :friend_id)
  end


end
