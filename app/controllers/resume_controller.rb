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
      respond_to do |format|
        if @resume.save # verify_recaptcha(model: @resume, message: 'You enter wrong captcha', attribute: :base) &&
          format.json {render json: {notice: 'Resume has been sent.'}}
        else
          @resume.upload_file = UploadFile.new
          format.json {render json: @resume.errors.full_messages.join(', '), status: :unprocessable_entity}
          #flash.now[:error] = @resume.errors.full_messages.join(', ')
          #render nothing: true
        end
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
