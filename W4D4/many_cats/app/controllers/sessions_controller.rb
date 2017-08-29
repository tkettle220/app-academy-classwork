class SessionsController < ApplicationController
  before_action :logged_in_check


  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name],params[:user][:password])
    if @user
      # session_token = @user.reset_session_token! # limits one login
      session_token = @user.ensure_session_token
      @user.save
      LoggedInSession.create(user_id: @user.id, ip_address: request.remote_ip, user_agent: request.env["HTTP_USER_AGENT"])
      session[:session_token] = session_token
      redirect_to cats_url
    else
      flash.now[:errors] = ["User or Password invalid"]
      render :new
    end
  end

  def destroy
    user = current_user
    user.reset_session_token! if user
    session[:session_token] = nil
    session = LoggedInSession.find_by(user_id: current_user.id, ip_address: request.remote_ip, user_agent: request.env["HTTP_USER_AGENT"])
    session.destroy unless session.nil?
    redirect_to new_session_url
  end


end
