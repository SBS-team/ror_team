class PostsController < ApplicationController
  before_action :category, only: [:index , :show]
  def category
    @category = Category.all
    #@tag = Post.tag_counts_on(:tags)
  end
  # GET /posts
  def index
    if !params[:category_id].nil?
      @post = Post.joins(:post_categories).where("post_categories.category_id = :x", :x=>params[:category_id])
    elsif !params[:tag_id].nil?
      #@post = Post.joins(:taggings).where("taggings.tag_id = :x", :x=>params[:tag_id])
    else
      @post = Post.search_posts_based_on_like(params[:search])
    end

  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order("id").page(params[:page]).per(5)
  end

end
