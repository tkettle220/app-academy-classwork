class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :login!, :logged_in_check

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session_token = user.reset_session_token!
    user.save
    session[:session_token] = session_token
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_check
    if ["new", "create"].include?(params[:action]) && logged_in?
      redirect_to cats_url
    end
  end
end
