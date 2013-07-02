class JobsController < ApplicationController

  before_filter :last_posts_and_jobs , :only => [:index, :show, :create]

  def index
    @resume = Resume.new
    @jobs = Job.page(params[:page])
    @jobs_for_select = Job.select(:id, :title)
  end

  def show
    @resume = Resume.new
    @job = Job.find(params[:id])
  end

  def create
    create_resume
  end

private

  def create_resume
    @resume = Resume.new(resume_params)
    @job = Job.find(@resume.job_id)

    if @resume.save
      redirect_to jobs_path, notice: 'Your resume is successfully sent.'
    else
      errors = ''
      @resume.errors.full_messages.each do |msg|
        errors << msg.to_s + '</br>'
      end
      flash.now[:error] = errors
      render :show
    end
  end

  def resume_params
    params.require(:resume).permit(:job_id, :name, :email, :phone, :decription, upload_files_attributes: [:filename, :id])
  end

end