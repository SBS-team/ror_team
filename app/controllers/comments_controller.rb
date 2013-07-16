class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @comment = current_user.comments.new
  end

  def create
    @post = Post.find_by_slug(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id=@post.id

    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:alert] = 'Comment create error.'
    end
    redirect_to special_post_path(@post.created_at.strftime('%d_%m_%Y'), @post)
  end
  private
  def comment_params
    params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type)
  end
end
