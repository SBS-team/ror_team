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

  form :html => {:enctype => "multipart/form-data" } do |f|
    f.semantic_errors :base
    f.inputs 'Job Details' do
      f.input :title
      f.input :description, :as => :html_editor
      f.inputs :for => :upload_file do |file|
        file.input :img_name, :as => :file, :hint => file.object.img_name.nil? ? file.template.content_tag(:span, "no map yet") : file.template.image_tag(file.object.img_name.url(:thumb))
        file.input :remote_img_name_url, :as => :url
      end
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

    def new
      @job = Job.new
      @job.upload_file = UploadFile.new
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
      params.require(:job).permit(:title, :description, upload_file_attributes: [:img_name, :remote_img_name_url, :id])
    end
  end

end