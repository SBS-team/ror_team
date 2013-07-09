class WorkController < ApplicationController

  before_filter :last_posts_and_jobs , :only => [:index, :show]

  def index
    @projects = Project.preload(:technologies => :technology_category).page params[:page]
  end

  def show
    @projects = Project.where(:id=>params[:id]).preload(:technologies).page params[:page]
    render :index
  end

end
