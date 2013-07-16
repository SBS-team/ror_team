ActiveAdmin.register Job do

  filter :title

  index do
    selectable_column
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
      f.input :description, :as => :html_editor
    end
    f.actions
  end

  controller do
    def create
       @job = Job.new(job_params)
       if @job.save
        redirect_to admin_job_url(@job), notice: 'Job was successfully created.'
        else
        render :new
      end
    end
    def update
      @job = Job.find(params[:id])
      if @job.update(job_params)
        redirect_to admin_job_url(@job), notice: 'Job was successfully updated.'
      else
        render :edit
      end
    end

    private
    def job_params
      params.require(:job).permit(:title, :description)
    end
  end

end