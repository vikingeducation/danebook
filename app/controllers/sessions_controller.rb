class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash.now[:success] = 'Login successful.'
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash.now[:success] = 'You are now logged out.'
    redirect_to root_url
  end
end
