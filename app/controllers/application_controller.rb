class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login, :except => [:new, :create]


  private
  def require_current_user
    unless params[:id] == current_user.id.to_s
      flash[:error] = "You're not authorized to view this"
      redirect_to root_url
    end
  end

  def correct_user?
    params[:id].nil? || params[:id] == current_user.id.to_s
  end
  helper_method :correct_user?

  def require_login
    unless signed_in_user?
      flash[:error] = "Not authorized, please sign in!"
      redirect_to login_path  #< Remember this is a custom route
    end
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

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

  def login_redirect
    redirect_to timeline_path if signed_in_user?
  end
  helper_method :login_redirect



end
