class HomeController < ApplicationController

  def index
    @post = Post.limit(4)
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
