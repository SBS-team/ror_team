class PostsController < ApplicationController
  #before_action :set_post, only: [:show]

  # GET /posts
  def index
    @posts = Post.all
    @tags = Post.tag_counts_on(:tags)
    @popular_post = Post.order("comments_count").limit(3)
    @category = Category.all
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order("id").page(params[:page]).per(5)
    @tags = Post.tag_counts_on(:tags)
    @popular_post = Post.order("comments_count").limit(3)
    @category = Category.all
  end

end
