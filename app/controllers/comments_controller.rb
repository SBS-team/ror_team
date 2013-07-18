class CommentsController < ApplicationController

  #before_filter :authenticate_user!

  def new
    @comment = current_user.comments.new
    @user = User.new
  end

  def create

      if params[:comment][:user_attributes]
        logger.info '-'*250
        #@user = User.find_or_create_by(:email => params[:comment][:user_attributes][:email], :password => '123456789', :first_name => params[:comment][:user_attributes][:first_name])
        @user = User.where(:email => params[:comment][:user_attributes][:email]).first_or_create(:password => '123456789', :nickname => params[:comment][:user_attributes][:first_name])
        logger.info '-'*250
      end
      @post = Post.find_by_slug(params[:post_id])
      logger.info '*'*250
      logger.info current_user.inspect
      logger.info '*'*250
      current_user ? @comment = current_user.comments.build(comment_params) : @comment = @user.comments.build(comment_params)
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

  def user_params
    params.require(:comment).permit(:user_attributes[:email, :first_name])
  end

end
