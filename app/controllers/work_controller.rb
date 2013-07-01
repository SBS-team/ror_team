class WorkController < ApplicationController
  def index
    @projects = Project.all.preload(:technologies).page params[:page]
  end

  def show
    @projects = Project.where(:id=>params[:id]).preload(:technologies).page params[:page]
    render "work/index"
  end

end
