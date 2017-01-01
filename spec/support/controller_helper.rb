module ControllerHelper

  def login(user)
    cookies[:auth_token] = user.auth_token
  end

  def logout
    cookies.delete(:auth_token)
  end

  def current_user
    User.find_by_auth_token(cookies[:auth_token]) if User.exists?(auth_token: cookies[:auth_token]) && cookies[:auth_token]
  end

  def signed_in_user?
    !!current_user
  end
end
