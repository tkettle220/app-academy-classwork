class CatsController < ApplicationController

  before_action :validate_owner

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.includes(rental_requests: :requester).find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def validate_owner
    if ["edit", "update"].include?(params[:action])
      if current_user.nil?
        redirect_to new_session_url
        return
      end

      owned_cats = current_user.cats
      unless owned_cats.map{|cat| cat.id }.include?(params[:id].to_i)
        redirect_to new_session_url
      end
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
