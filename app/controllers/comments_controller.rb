class CommentsController < ApplicationController

  def new
    @comment = current_user.comments.new
    @user = User.new
  end

  def create

      if params[:comment][:user_attributes]
        name = params[:comment][:user_attributes][:first_name] == '' ? 'Guest' : params[:comment][:user_attributes][:first_name]
        @user = User.where(:email => params[:comment][:user_attributes][:email]).first_or_create(:password => '123456789', :nickname => name)
      end

      session[:user_id] = current_user ? current_user.id : @user.id

      @post = Post.find_by_slug(params[:post_id])
      @comment = current_user ? current_user.comments.build(comment_params) : @user.comments.build(comment_params)
      @comment.post_id = @post.id

      image = current_user ? @comment.commentable.image : '/assets/missing.png'

      respond_to do |format|
        if @comment.save
          format.json { render json: {:email => @comment.commentable.email, :created_at => @comment.created_at, :image => image, :nickname => @comment.commentable.nickname ,:comment => @comment, stat:  'succ',  :location => @post } }
        elsif @comment.invalid?
          format.json { render json: { comment_error: @comment.errors.messages, stat: 'error' } }
        end
      end
  end

  def edit
    @comment = Comment.find(params[:id])
    render json: {}
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: {:stat => 'deleted' }
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type)
  end

  def user_params
    params.require(:comment).permit(:user_attributes[:email, :first_name])
  end

end
