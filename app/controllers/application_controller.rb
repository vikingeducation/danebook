class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  


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
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_login
    unless signed_in_user?
      flash[:danger] = "Not authorized, please sign in!"
      redirect_to root_path
    end
  end

  def real_user_id
    params[:user_id] || params[:id] || current_user.id
  end
  helper_method :real_user_id

  def real_user
    User.find(real_user_id)
  end
  helper_method :real_user

  def user_header_name(user_id)
    "#{User.find(user_id).profile.first_name} #{User.find(user_id).profile.last_name}" if User.find(user_id).profile
  end
  helper_method :user_header_name

  def require_current_user
    unless params[:id] == current_user.id.to_s || params[:user_id] == current_user.id.to_s
      flash[:danger] = "You're not authorized for that action!"
      redirect_to root_path
    end
  end

  def find_like_id(user_id, likeable_id, likeable_type)
    like = Like.where("user_id = ? AND likeable_id = ? AND likeable_type = ?", user_id, likeable_id, likeable_type)
    like.ids[0]
  end
  helper_method :find_like_id


  

end
