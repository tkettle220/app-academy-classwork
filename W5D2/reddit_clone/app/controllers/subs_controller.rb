class SubsController < ApplicationController

  before_action :check_moderator

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to subs_url
    else
      flash.now[:errors]= @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def delete
    @sub = Sub.find(params[:id])
    @sub.delete
    redirect_to subs_url
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def check_moderator
    if ["edit"].include?(params[:action])
      unless current_user.subs.include?(Sub.find(params[:id]))
        flash[:errors] = "u cannot edit dis sub bak off nao!"
        redirect_to subs_url
      end
    end
  end

end
