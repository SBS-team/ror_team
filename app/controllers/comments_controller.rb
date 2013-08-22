class CommentsController < ApplicationController

  def create
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.build(comment_params)
    if current_admin_user && current_admin_user.role == 'admin'
      @comment.admin = true
    else
      @comment.admin = false
    end
    if verify_recaptcha(model: @comment, message: "You enter wrong captcha", attribute: :base) && @comment.save
      render json: {comment: @comment, stat: 'success', location: @post}
    else
      render json: {errors: @comment.errors.messages, stat: 'error' }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type, :nickname)
  end

end
