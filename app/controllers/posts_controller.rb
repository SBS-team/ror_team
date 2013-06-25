class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  # GET /posts
  def index
    @posts = Post.all
    @tags = Post.tag_counts_on(:tags)
    @popular_post = Post.order("comments_count").limit(3)
  end

  # GET /posts/1
  def show
    @comments = @post.comments.order("id").page(params[:page]).per(5)
    @post = Post.find(params[:id])
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

end
