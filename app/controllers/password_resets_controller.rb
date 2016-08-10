class PasswordResetsController < ApplicationController
  before_action :validate_reset_link, only: [:edit,:update]

  def new
  end

  def create
    if @user = User.find_by(email: params[:password_reset][:email])
      @user.make_reset_digest
      @user.send_reset_email
      flash[:info] = 'An email has been sent containing a link for resetting your password. Please check your email now. Your password reset link will expire in 24 hours.'
      redirect_to root_url
    else
      flash[:danger] = 'Invalid email address.'
      render 'new'
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
  end

  def update
    @user = User.find_by(email: params[:email])
    if @user.update_attributes(permit_password_params)
      flash[:success] = 'Your password has been updated!'
      redirect_to login_path
    else
      flash[:danger] = 'Invalid password combination.'
      render 'edit'
    end
  end

  private
    def validate_reset_link
      user = User.find_by(email: params[:email])
      unless user && user.activated? && user.authenticated?(:reset,params[:id])
        redirect_to root_url
      end
    end

    def permit_password_params
      permissible_params = [:password,:password_confirmation]
      params.require(:user).permit(permissible_params)
    end

end
