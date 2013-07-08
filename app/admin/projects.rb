ActiveAdmin.register Project do

  index do
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
        file.input :filename, :as => :file, :label => 'Image', :hint => file.template.image_tag(file.object.filename.url, :height => 200, :width => 200)
        file.input :id, :as => :hidden
      end
    end
    f.actions

  end

  controller do
    def create
      @project = Project.new(project_params)
       if @project.save
        redirect_to admin_project_url(@project), notice: 'Project was successfully created.'
       else
        render :new
      end
    end
    def update
      @project = Project.find(params[:id])
      if @project.update(project_params)
        redirect_to admin_project_url(@project), notice: 'Project was successfully updated.'
      else
        render :edit, notice: 'Error has occurred while updating.'
      end
    end
    private
    def project_params
      params.require(:project).permit(:name, :description, :since, :till, :team_size, :url, upload_files_attributes: [:filename, :id], :service_ids => [], :technology_ids => [])
    end
  end
end
