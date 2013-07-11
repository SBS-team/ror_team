ActiveAdmin.register Project do

  index do
    column :id
    column :name
    column :since
    column :till
    column :team_size
    column :url
    default_actions
  end

  form do |f|
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
        file.input :img_name, :as => :file, :label => 'Image', :hint => file.template.image_tag(file.object.img_name.url, :height => 200, :width => 200)
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
        redirect_to edit_admin_project_url(@project), notice: 'Project was successfully updated.'
      else
        render :edit
      end
    end
    private
    def project_params
      params.require(:project).permit(:name, :description, :since, :till, :team_size, :url, upload_files_attributes: [:img_name, :id])
    end
  end
end
