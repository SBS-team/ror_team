class JobsController < ApplicationController

  before_action :last_posts_and_jobs, only: [:index, :show]

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
      if verify_recaptcha(model: @resume, message: 'You enter wrong captcha', attribute: :base) && @resume.save
        redirect_to jobs_path, notice: 'Your resume is successfully sent.'
      else
        @resume.upload_file = UploadFile.new
        flash.now[:error] = @resume.errors.full_messages.join(', ')
        last_posts_and_jobs
        render 'show'
      end
    else
      @resume.upload_file = UploadFile.new
      redirect_to jobs_path, alert: 'Sorry. No jobs found'
    end
  end

end