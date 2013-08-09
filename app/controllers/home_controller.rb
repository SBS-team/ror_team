class HomeController < ApplicationController

  before_action :last_posts_and_jobs , only: :index

  def index
    @technologies = Technology.includes(:upload_file).order('random()').limit(8)
    @projects = Project.includes(:upload_files).order('random()').limit(8)
  end

end
