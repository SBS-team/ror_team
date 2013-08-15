ActiveAdmin.register Job do

  menu :parent => 'Careers'

  filter :title, :as => :string
  filter :description, :as => :string
  filter :created_at

  index do
    selectable_column
    column :image do |job|
      unless job.upload_file.blank?
        image_tag(job.upload_file.img_name.url(:thumb), height: 30)
      end
    end
    column :title do |job|
      link_to job.title, admin_job_path(job)
    end
    column :description do |job|
      job.description.truncate(200)
    end
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    panel 'Job Details' do
      attributes_table_for job do
        row :image do |job|
          unless job.upload_file.blank?
            image_tag(job.upload_file.img_name.url(:thumb))
          end
        end
        row :title
        row :description
        row :created_at
        row :updated_at
      end
    end
  end

  form :html => {:enctype => 'multipart/form-data' } do |f|
    f.semantic_errors :base
    f.inputs 'Job Details' do
      f.input :title
      f.input :description, :as => :html_editor
      f.inputs :for => [:upload_file, f.object.upload_file || UploadFile.new] do |file|
        file.input :img_name, :as => :file, :hint => file.object.img_name.nil? ? file.template.content_tag(:span, 'no map yet') : file.template.image_tag(file.object.img_name.url(:thumb))
        file.input :remote_img_name_url, :as => :url
        file.input :id, :as => :hidden
      end
    end
    f.actions
  end

  controller do

    def scoped_collection
      Job.includes([:upload_file]).page(params[:page]).per(30)
    end

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
      params.require(:job).permit(:title, :description, upload_file_attributes: [:img_name, :remote_img_name_url, :id])
    end

  end

end