class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

    def require_login
      unless signed_in_user?
        flash[:danger] = "You need to sign in to view this"
        redirect_to login_path
      end
    end

    def require_current_user
      unless current_user == User.find(params[:id])
        flash[:danger] = "Access denied!!!"
        redirect_to root_path
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

    def user_liked?(resource)
      !!resource.likers.include?(current_user)
    end
    helper_method :user_liked?

    def user_liked_id(post)
      post.likes.first.id
    end
    helper_method :user_liked_id

    def get_instance(id, klass)
      unless instance = klass.find_by_id(id)
        return nil
      end
      instance
    end
end
