class CommentsController < ApplicationController

  def new
    @comment = new
  end

  def create

      @post = Post.find_by_slug(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.post_id = @post.id
      render json: {:comment => @comment, stat:  'succ', :location => @post }

  end

  private

  def comment_params
    params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type)
  end

end
