class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @comment = current_user.comments.new
  end

  def create
      @post = Post.find_by_slug(params[:post_id])
      @comment = current_user.comments.build(comment_params)
      @comment.post_id = @post.id

      respond_to do |format|
        if @comment.save
          format.js   {}
          format.json { render json: @comment, status: :created, location: @post }
        else
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
  end

  private
  def comment_params
    params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type)
  end

end
