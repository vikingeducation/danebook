class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def sign_in(user)
  	session[:user_id] = user.id
  	@current_user = user
  end

  def sign_out
  	@current_user = nil
  	session.delete(:user_id)
  end

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def object_owner
    @object_owner ||= User.find(params[:user_id])
  end
  helper_method :object_owner

  def current_user=(user)
  	@current_user = user
  end

  def signed_in_user?
  	!!current_user
  end
  helper_method :signed_in_user?

  def require_login
  	unless signed_in_user?
  		flash[:error] = "Not authorized. Please sign in."
  		redirect_to root_path
  	end
  end

  #requires a user to own the current page with parameter id (user pages)
  def require_current_user
  	unless User.find(params[:id]) == current_user
  		flash[:error] = "Sorry! Viewing not authorized."
  	end
  end
  helper_method :require_current_user

  #requires a user to own the current page with parameter user id (all except user pages)
  def require_object_owner
    if User.find(params[:user_id]) != current_user
      flash[:error] = "Sorry! Viewing not authorized."
      redirect_to :back
    end
  end
  helper_method :require_object_owner

  #checks if a user owns the current page he/she is on
  def object_owner?
    User.find(params[:user_id]) == current_user
  end
  helper_method :object_owner?

  #checks if user owns a particular object
  def object_owner_for_resource?(object)
    object.user == current_user
  end
  helper_method :object_owner_for_resource?


end
