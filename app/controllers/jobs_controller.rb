class JobsController < ApplicationController

  before_action :last_posts_and_jobs, only: [:index, :show]
  before_action :resume_new, only: [:index, :show]

  def index
    @jobs = Job.includes(:upload_file).order('created_at DESC').page(params[:page]).per(3)
  end

  def show
    @job = Job.includes(:upload_file).find(params[:id])
  end

  def create
    @resume = Resume.new(resume_params)
    unless @resume.job_id.blank?
      @job = Job.find(@resume.job_id)
      if @resume.save
        redirect_to jobs_path, notice: 'Your resume is successfully sent.'
      else
        @resume.upload_file = UploadFile.new
        last_posts_and_jobs
        render 'show'
      end
    else
      @resume.upload_file = UploadFile.new
      redirect_to jobs_path, alert: 'Sorry. No jobs found'
    end
  end

  private
  def resume_params
    params.require(:resume).permit(:job_id, :name, :email, :phone, :description, upload_file_attributes: [:filename, :id])
  end

  def resume_new
    @resume = Resume.new
    @resume.build_upload_file
  end

end