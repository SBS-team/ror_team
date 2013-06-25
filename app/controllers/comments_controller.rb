class CommentsController < ApplicationController
  before_action :get_commentable
  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end
  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to @commentable, :notice => "Thank you!"
    else
      render :new
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:description, :post_id)
  end

  private
  def get_commentable
    resource, id = request.path.split("/")[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
    redirect_to :home unless defined?(@commentable)
  end
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
