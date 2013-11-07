class HomeController < ApplicationController

  before_action :last_posts_and_jobs , only: :index

  def index
    @projects = Project.includes(:upload_files).order('random()').limit(8)
    @jobs = Job.includes(technologies: :upload_file).order('created_at DESC')
  end

end
