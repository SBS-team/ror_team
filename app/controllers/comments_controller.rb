class CommentsController < ApplicationController

  #def new
  #  @comment = new
  #end

  def create
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.build(comment_params)
    if current_admin_user && current_admin_user.role == 'admin'
      @comment.admin = true
    else
      @comment.admin = false
    end
    if @comment.save
      id = @comment.change_humanizer_question
      render json: {:comment => @comment, :humanizer_question => @comment.humanizer_question, :humanizer_question_id => id, :stat => 'success', :location => @post }
    else
      render json: {:error => @comment.errors.messages, :stat => 'error' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type, :nickname, :humanizer_answer, :humanizer_question_id)
  end

end
