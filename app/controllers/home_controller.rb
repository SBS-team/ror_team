class HomeController < ApplicationController

  def index
    #@post = Post.limit(4)
    @tech = Technology.order("random()").limit(8)
    @some_projects = Project.order("random()").limit(8)

  end

  #def show
  #  @post = Post.find(params[:id])
  #
  #  #respond_to do |format|
  #  #  format.html # show.html.erb
  #  #  format.json { render json: @post }
  #  #end
  #end

end
