class ProjectsController < ApplicationController

  before_filter :last_posts_and_jobs , only: [:index, :show]

  def index
    @projects = Project.includes([{technologies: :technology_category}, :services, :project_services,
                                  :upload_files]).order('created_at DESC').page(params[:page]).per(2)
  end

  def show
    @project = Project.includes(:upload_files, technologies: :upload_file).find(params[:id])
    respond_to do |format|
      format.html {render :show, layout: false}
    end
  end

end
