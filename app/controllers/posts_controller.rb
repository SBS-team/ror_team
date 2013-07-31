class PostsController < ApplicationController
  include ActionView::Helpers::DateHelper #include for use helper "time ago" to sent into js
  before_action :category, only: [:index , :show]
  before_action :recent_and_popular_posts, only: :show

  # GET /posts
  def index
    @posts = if !params[:category_name].blank?
              Post.joins(:categories).where("categories.name = :category_name", :category_name=>params[:category_name]).order('created_at DESC').page(params[:page]).per(5)
            elsif !params[:tag_name].blank?
              Post.joins(:tags).where("tags.name = :tag_name", :tag_name=>params[:tag_name]).order('created_at DESC').page(params[:page]).per(5)
            else
              Post.search_posts_based_on_like(params[:search]).order('created_at DESC').page(params[:page]).per(5)
            end
    unless params[:search].blank?
      if !params[:search].nil? && @posts.empty?
        flash.now[:error] = "#{t('.your_search_for')} #{params[:search]} #{t('.returned_no_hits')}"
      else
        flash.now[:notice] = "#{t('.your_search_for')} #{params[:search]} results"
      end
    end
    respond_to do |format|
      format.html { render :index }
      format.rss { render :index, :content_type => Mime::XML }
    end
  end

  # GET /posts/1
  def show
    session[:return_to] = request.fullpath
    @post = Post.find_by_slug(params[:id])
    if request.path != special_post_path(@post.created_at.strftime('%d_%m_%Y'), @post)
      redirect_to @post, status: :moved_permanently
    end
    @comments = @post.comments.order('id DESC').limit(3).reverse

  end

  def comments_show_all

    current_post = Post.find(params[:id])
    comments_count = current_post.comments.count
    comments_count -= 3

    comments =  current_post.comments.limit(comments_count).reverse
    id = []
    comments.each do |val|
     id << val.commentable_id
    end
    users = User.where("id IN (?)", id)
    user_comments = []

    comments.map do |val|
      users.map do |user|
        if val.commentable_id == user.id
          time_ago = time_ago_in_words val.created_at
          user_comments << {:comment => val , :user => user, :time_ago => time_ago }
        end
      end
    end

    render json: {:comments => user_comments }

  end

  private
  def category
    @categories = Category.joins(:posts).group('categories.id')
    @tags = Post.tag_counts_on(:tags).order("random()")
  end

  def recent_and_popular_posts
    @recent_posts = Post.order("created_at DESC").limit(5)
    @popular_posts = Post.order("comments_count DESC").limit(5)
  end
end
