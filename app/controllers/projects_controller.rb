class ProjectsController < ApplicationController

  before_filter :last_posts_and_jobs , :only => [:index, :show]

  def index
    @projects = Project.order('created_at DESC').preload(:technologies => :technology_category).page(params[:page]).per(2)
  end

  def show
    @project = Project.find(params[:id])#.preload(:technologies => :technology_category)
  end

end
