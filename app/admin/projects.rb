ActiveAdmin.register Project do

  filter :name
  filter :services
  filter :technologies

  index do
    selectable_column
    column :id
    column :name
    column :since
    column :till
    column :team_size
    column :url
    column :technologies do |technology|
      technology.technologies.collect(&:name).join(', ')
    end
    column :services do |service|
      service.services.collect(&:name).join(', ')
    end
    default_actions
  end

  show do
    panel 'Project Details' do
      attributes_table_for project do
        row :name
        unless project.upload_files.blank?
          project.upload_files.each do |file|
            row :image do
              image_tag(file.img_name.url(:thumb), height: 50)
            end
          end
        end
        row :description
        row :since
        row :till
        row :team_size
        row :url
        row :technologies do |technology|
          technology.technologies.collect(&:name).join(', ')
        end
        row :services do |service|
          service.services.collect(&:name).join(', ')
        end
        row :created_at
      end
    end
  end


  form :html => {:enctype => "multipart/form-data" } do |f|
    f.semantic_errors :base
    f.inputs "Project Details" do
      f.input :name
      f.input :description, as: :html_editor
      f.input :since
      f.input :till
      f.input :team_size
      f.input :url
      f.input :technologies, :as => :check_boxes
      f.input :services, :as => :check_boxes
      f.has_many :upload_files do |file|
        file.input :img_name, :as => :file, :hint => file.object.img_name.nil? ? f.template.content_tag(:span, "no map yet") : file.template.image_tag(file.object.img_name.url(:thumb))
        file.input :remote_img_name_url, :as => :url
        file.input :remove_img_name, :as => :boolean , :label => 'Delete image?'
        file.input :id, :as => :hidden
      end
    end
    f.actions

  end

  controller do
    def create
      begin
        @project = Project.new(project_params)
        @project.save!
        # TODO make this with nested attributes
        technologies = Technology.find(params[:project][:technology_ids].reject { |i| i.to_i <= 0 })
        technologies.each { |i| i.projects << @project }
        services = Service.find(params[:project][:service_ids].reject { |i| i.to_i <= 0 })
        services.each { |i| i.projects << @project }
        redirect_to admin_project_url(@project), notice: t('.proj_create')
      rescue Exception => e
        logger.error(e.message)
        render 'new'
      end
    end
    def update
      @project = Project.find(params[:id])
      if @project.update(project_update_params)
        unless params[:project][:upload_files_attributes].blank?
          params[:project][:upload_files_attributes].each_value do |file|
            if file[:remove_img_name].to_i == 1
              UploadFile.find(file[:id]).destroy
            end
          end
        end
        redirect_to admin_project_url(@project), notice: t('.proj_update')
      else
        render :edit, notice: t('.proj_error')
      end
    end
    private
    def project_params
      params.require(:project).permit(:name, :description, :since, :till, :team_size, :url, upload_files_attributes: [:img_name, :id])
    end
    def project_update_params
      params.require(:project).permit(:name, :description, :since, :till, :team_size, :url, upload_files_attributes: [:img_name, :id, :remove_img_name], :service_ids => [], :technology_ids => [])
    end
  end
end
