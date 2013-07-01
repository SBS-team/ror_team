class PostsController < ApplicationController
  before_action :category, only: [:index , :show]

  # GET /posts
  def index
    @posts = if !params[:category_name].nil?
              Post.joins(:categories).where("categories.name = :category_name", :category_name=>params[:category_name])
            elsif !params[:tag_name].nil?
              Post.joins(:tags).where("tags.name = :tag_name", :tag_name=>params[:tag_name])
            else
              Post.search_posts_based_on_like(params[:search])
    end

  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order("id").page(params[:page]).per(5)
    @tags = Post.tag_counts_on(:tags)
    @popular_post = Post.order("comments_count").limit(3)
    @category = Category.all
    @user = User.all

  end

  private

  def category
    @categories = Category.all
    @tags = Post.tag_counts_on(:tags)
  end
end
