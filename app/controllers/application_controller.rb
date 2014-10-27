class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def require_current_user
    unless params[:user_id] == current_user.id.to_s
      flash[:error] = "Hey! You're not authorized for that."
      redirect_to root_url
    end
  end

  def require_login
    unless signed_in_user?
      flash[:error] = "Hey! Sign in first"
      redirect_to login_url
    end
  end

  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end
end