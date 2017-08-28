class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save!
      render json: comment
    else
      render json: Comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: @comment
  end

  def index
    user_id = comment_params[:user_id]
    artwork_id = comment_params[:artwork_id]
    if user_id
      @comments = Comment.find_by(user_id: comment_params[:user_id])
    else
      @comments = Comment.find_by(artwork_id: artwork_id)
    end
    if @comments
      render json: @comments
    else
      render json: Comment.errors.full_messages, status: 404
    end
  end

  private

  def comment_params
    params[:comment].permit(:user_id, :artwork_id)
  end
end
