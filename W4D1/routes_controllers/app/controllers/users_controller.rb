class UsersController < ApplicationController
  def index
    @users = User.all
    if @users
      render json: @users
    else
      render json: User.errors.full_messages, status: 404
    end
  end

  def create
    user = User.new(user_params)
    if user.save!
      render json: user
    else
      render json: User.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: @user
    else
      render json: User.errors.full_messages, status: 404
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) && @user.save!
      render json: @user
    else
      render json: User.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: @user
  end


private
  def user_params
    params[:user].permit(:username)
  end

end
