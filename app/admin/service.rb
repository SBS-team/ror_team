ActiveAdmin.register Service do

  menu :parent => 'Skills & Service'

  filter :projects
  filter :name

  index do
    selectable_column
    column :image do |service|
      unless service.upload_file.blank?
        image_tag(service.upload_file.img_name.url(:thumb), height: 30)
      end
    end
    column :name do |service|
      link_to service.name, admin_service_path(service)
    end
    column :created_at
    column :updated_at

    default_actions
  end

  show do
    panel 'Job Details' do
      attributes_table_for service do
        row :name
        row :image do |service|
          unless service.upload_file.blank?
            image_tag(service.upload_file.img_name.url(:thumb))
          end
        end
        row :created_at
        row :updated_at
      end
    end
  end

  form :html => {:enctype => 'multipart/form-data' } do |f|
    f.semantic_errors :base
    f.inputs 'Service Details', :multipart => true do
      f.input :name
      f.inputs :for => [:upload_file, f.object.upload_file || UploadFile.new] do |file|
        file.input :img_name, :as => :file, :hint => file.object.img_name.nil? ? file.template.content_tag(:span, 'no map yet') : file.template.image_tag(file.object.img_name.url(:thumb))
        file.input :remote_img_name_url, :as => :url
        file.input :id, :as => :hidden
      end
    end
    f.actions
  end

  controller do
    def create
       @service = Service.new(service_params)
       if @service.save
        redirect_to admin_service_url(@service), notice: 'Service was successfully created.'
       else
        render :new
      end
    end
    def update
      @service = Service.find(params[:id])
      if @service.update(service_params)
        redirect_to admin_service_url(@service), notice: 'Service was successfully updated.'
      else
        render :edit
      end
    end

    private
    def service_params
      params.require(:service).permit(:name, upload_file_attributes: [:img_name, :remote_img_name_url, :id])
    end
  end
end