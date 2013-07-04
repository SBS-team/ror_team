class JobsController < ApplicationController

  before_filter :last_posts_and_jobs , :only => [:index, :show, :create]

  def index
    @resume = Resume.new
    @jobs = Job.page(params[:page]).per(3)
    @all_jobs_for_select = Job.select(:id, :title)
  end

  def show
    @resume = Resume.new
    @job = Job.find(params[:id])
  end

  def create
    create_resume
  end
  def new

  end


private
  def create_resume
    @resume = Resume.new(resume_params)
    @job = Job.find(@resume.job_id)
    if @resume.save
      redirect_to jobs_path, notice: 'Your resume is successfully sent.'
    else
      render 'show'
    end
  end

  def resume_params
    params.require(:resume).permit(:job_id, :name, :email, :phone, :description, upload_files_attributes: [:filename, :id])
  end

end