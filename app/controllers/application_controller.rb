class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

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

  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end

  def current_user
    @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end

  def require_login
    unless current_user
      flash[:warning] = "Unauthorized action"
      redirect_to root_path
    end
  end

  def require_current_user
    unless current_user?(params[:user_id] || params[:id])
      flash[:warning] = "Unauthorized action"
      redirect_to root_path
    end
  end

  def current_user?(user_id)
    current_user && (user_id.to_i == current_user.id)
  end

  def signed_in_user?
    !!current_user
  end

  helper_method :current_user
  helper_method :current_user?
  helper_method :signed_in_user?


end
