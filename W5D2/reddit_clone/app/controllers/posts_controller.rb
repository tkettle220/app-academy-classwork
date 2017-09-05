class PostsController < ApplicationController

  before_action :check_author

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save!
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to subs_url
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def delete
    @post = Post.find(params[:id])
    @post.delete
    redirect_to subs_url
  end

  def upvote
    vote(1)
  end

  def resetvote
    vote(0)
  end

  def downvote
    vote(-1)
  end

  def vote(val)
    @post = Post.find(params[:id])
    @vote = @post.votes.find_or_initialize_by(liker: current_user)
    unless @vote.update(value: val)
      flash[:errors] = @vote.errors.full_messages
    end

    redirect_to post_url(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def check_author
    if ["edit"].include?(params[:action])
      post = Post.find(params[:id])
      unless current_user.posts.include?(post)
        flash[:errors] = "u cannot edit dis post bak off nao!"
        redirect_to post_url(post)
      end
    end
  end
end
