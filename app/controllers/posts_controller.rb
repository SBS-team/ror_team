class PostsController < ApplicationController

  before_action :category, only: [:index , :show, :archives]
  before_action :recent_and_popular_posts, only: :show

  def index
    @posts = if !params[:category_name].blank?
               Post.joins(:categories).includes([:tags, :upload_file]).where('categories.name = :category_name', category_name: params[:category_name]).page(params[:page]).per(5)
             elsif !params[:tag_name].blank?
               Post.joins(:tags).includes([:categories, :upload_file]).where('tags.name = :tag_name', tag_name: params[:tag_name]).page(params[:page]).per(5)
             else
               Post.includes([:tags, :categories, :upload_file]).search_posts_based_on_like(params[:search]).page(params[:page]).per(5)
             end
    unless params[:search].blank?
      if params[:search].length > 50
        flash.now[:error] = "#{t('.search_max_error')}"
      elsif !params[:search].nil? && @posts.empty?
        flash.now[:error] = "#{t('.your_search_for')} #{params[:search]} #{t('.returned_no_hits')}"
      else
        flash.now[:notice] = "#{t('.your_search_for')} '#{params[:search]}' results"
        gon.search_text = params[:search]
      end
    end
    respond_to do |format|
      format.html {render :index, layout: 'blog'}
      format.rss {render :index, content_type: Mime::XML}
    end
  end

  def archives
    if Date::MONTHNAMES.include? params[:month].to_s.capitalize
      if params[:year].to_i <= DateTime.now.year.to_i
        from_date = DateTime.new(params[:year].to_i, Date::MONTHNAMES.index(params[:month].to_s.capitalize), 1)
        till_date = from_date + 1.month
        @posts = Post.includes([:tags, :categories, :upload_file]).where('created_at >= ? AND created_at < ?', from_date, till_date).page(params[:page]).per(5)
        if @posts.blank?
          flash.now[:error] = "No created posts at: #{from_date.strftime('%B %Y')}"
        else
          flash.now[:notice] = "Posts created at: #{from_date.strftime('%B %Y')}"
        end
        render :index, layout: 'blog'
      else
        render 'public/404', layout: false, status: 404
      end
    else
       render 'public/404', layout: false, status: 404
    end
  end

  def show
    @post = Post.includes([:tags, :categories, :upload_file, :comments]).find_by_slug!(params[:id])
    @comments = @post.comments.order('id DESC').limit(3).reverse
    @comments_count = @post.comments.count
    respond_to do |format|
      format.html {render :show, layout: 'blog'}
    end
  end

  def comments_show_all
    post = Post.find(params[:id])
    comments = (post.comments.order('created_at DESC').limit(post.comments_count).offset(params[:offset]))
    render json: {comments: comments}
  end

  private
  def category
    @categories = Category.includes(:posts).group('categories.id')
    @tags = Post.tag_counts_on(:tags).order('count DESC').limit(20)
  end

  def recent_and_popular_posts
    @recent_posts = Post.order('created_at DESC').limit(5)
    @popular_posts = Post.order('comments_count DESC').limit(5)
  end

end