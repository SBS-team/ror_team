class JobsController < ApplicationController

    before_filter :last_posts_and_jobs , :only => [:index, :show]

  def index
    @resume = Resume.new
    @jobs = Job.page(params[:page]).per(4)
    @jobs_for_select = Job.select(:id, :title)
  end

  def show
    @resume = Resume.new
    @job = Job.find(params[:id])
  end

  def create
    @resume = Resume.create(resume_params)
    respond_to do |format|
      if @resume.save
        format.html { redirect_to jobs_path, notice: 'Post was successfully created.' }
      else
        format.html { redirect_to :back, notice: 'Error.' }
      end
    end
  end
end

private

def resume_params
  params.require(:resume).permit(:job_id, :name, :email, :phone, :decription, upload_files_attributes: [:filename, :id])
end