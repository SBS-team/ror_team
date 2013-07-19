class CommentsController < ApplicationController

  #before_filter :authenticate_user!

  def initialize
    @errors = ActiveModel::Errors.new(self)
  end

  def new
    @comment = current_user.comments.new
    @user = User.new
  end

  def create

      if params[:comment][:user_attributes]
        @user = User.where(:email => params[:comment][:user_attributes][:email]).first_or_create(:password => '123456789', :nickname => params[:comment][:user_attributes][:first_name])
      end

      @post = Post.find_by_slug(params[:post_id])
      current_user ? @comment = current_user.comments.build(comment_params) : @comment = @user.comments.build(comment_params)
      @comment.post_id = @post.id

      #if @comment.invalid?
      #  @comment_errors = @comment.errors.messages
      #  flash[:error] = @comment_errors
      #end



      respond_to do |format|
        if @comment.save
          format.js   {}
          format.json { render json: @comment, status: :created, location: @post }
        elsif @comment.invalid?
          format.json { render json: { comment_error: @comment.errors.messages, status: :unprocessable_entity } }
        end
      end
  end


  private

  def comment_params
    params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type)
  end

  def user_params
    params.require(:comment).permit(:user_attributes[:email, :first_name])
  end

end
