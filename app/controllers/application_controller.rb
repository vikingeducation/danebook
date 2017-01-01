# Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  helper_method :current_user, :signed_in_user?, :friends?

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
    @current_user ||= User.find_by_auth_token(cookies[:auth_token])
  end

  def signed_in_user?
    !current_user.nil?
  end

  def require_login
    unless signed_in_user?
      flash[:error] = 'Not authorized, please sign in!'
      redirect_to root_url
    end
  end
end
