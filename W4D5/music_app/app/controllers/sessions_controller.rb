class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_user_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Email or Password Invalid"]
      redirect_to new_session_url
    end
  end

  def destroy
    user = current_user
    user.reset_session_token! if user
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
