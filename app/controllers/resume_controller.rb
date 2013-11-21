class ResumeController < ApplicationController

  def new
    @resume = Resume.new
    @jobs = Job.order('created_at DESC')
    @resume.build_upload_file
    respond_to do |format|
      format.html {render :new, layout: false}
    end
  end

  def create
    @resume = Resume.new(resume_params)
    unless @resume.job_id.blank?
      @job = Job.find(@resume.job_id)
      if (verify_recaptcha(model: @resume, message: 'You enter wrong captcha', attribute: :base) && @resume.save)
        render :create, notice: 'Resume has been sent'
      else
        @resume.upload_file = UploadFile.new
        render json: {errors: @resume.errors.full_messages}, status: :unprocessable_entity
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

end
