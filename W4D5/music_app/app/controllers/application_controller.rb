class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  helper_method :login!, :current_user

  def login!(user)
    session_token = user.reset_session_token!
    user.save
    session[:session_token] = session_token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

end
