class CommentsController < ApplicationController


  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    post = Post.find(params[:comment][:post_id])
    @comment.post = post
    @comment.parent_comment_id = params[:comment][:parent_comment_id]
    if @comment.save
      redirect_to post_url(post)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    @comment.delete
    render posts_url(post)
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
    @comment = Comment.find(params[:id])
    @vote = @comment.votes.find_or_initialize_by(liker: current_user)
    unless @vote.update(value: val)
      flash[:errors] = @vote.errors.full_messages
    end

    redirect_to post_comment_url(@comment)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
