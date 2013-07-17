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

  #def ajax_add
  #  @post = Post.find_by_slug(params[:post_id])
  #  @comment = current_user.comments.build(comment_params)
  #  @comment.post_id = @post.id
  #  @comment.save
  #  #if @comment.save
  #  #  flash[:notice] = 'Comment was successfully created.'
  #  #else
  #  #  flash[:error] = 'Comment create error.'
  #  #end
  #end


  #def like
  #      like_id = params[:id]
  #      status = false
  #      if (@l = Like.where(:image_id => like_id, :user_id => current_user.id)).blank?
  #          like = current_user.likes.create(:image_id => like_id)
  #          status = true
  #          ActiveSupport::Notifications.instrument("images.like", :like => like, :user => current_user)
  #      else
  #                @l.destroy_all
  #                status = false
  #            end
  #    all_likes = Like.where(:image_id =>like_id).size
  #    render :json => {:all_likes=>all_likes, :status => status}, layout: false
  #end

  private
  def comment_params
    params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type)
  end



end
