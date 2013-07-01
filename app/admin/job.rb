ActiveAdmin.register Job do

  index do
    column :id
    column :title
    column :description
    column :created_at
    column :updated_at
    default_actions
  end

  filter :email

  form do |f|
    f.inputs 'Job Details' do
      f.input :title
      f.input :description
    end
    f.actions
  end

  controller do
    def create
      begin
        @job = Job.new(job_params)
        @job.save!
        redirect_to admin_job_url(@job), notice: 'Job was successfully created.'
      rescue Exception => e
        logger.error(e.message)
        render 'new'
      end
    end
    def update
      @job = Job.find(params[:id])
      if @job.update(job_params)
        redirect_to admin_job_url(@job), notice: 'Job was successfully updated.'
      else
        render 'edit'
      end
    end

    private
    def job_params
      params.require(:job).permit(:title, :description)
    end
  end

end