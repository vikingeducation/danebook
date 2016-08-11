class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "You've successfuly signed in!"
      redirect_to user_timeline_path(current_user)
    else
      flash.now[:error] = "We couldn't sign you in"
      render new_user_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to new_user_path
  end
end
