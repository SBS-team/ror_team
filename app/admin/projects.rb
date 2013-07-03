ActiveAdmin.register Project do
  # Customize columns displayed on the new screen in the table
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
        file.input :filename, :as => :file, :label => 'Image'#, :hint => file.template.image_tag(file.object.filename.url(:thumb))
        file.input :id, :as => :hidden
      end
    end
    # f.inputs "Technologies" do
    #   f.semantic_fields_for :project_technology_technologies do |ptt|
    #     ptt.input :id, :as => :check_boxes, :collection => Technology.all
    #   end
    # end
    f.buttons
  end

  controller do
    def create
      begin
        @project = Project.new(project_params)
        @project.save!
        redirect_to admin_project_url(@project), notice: 'Project was successfully created.'
      rescue Exception => e
        logger.error(e.message)
        render 'new'
      end
    end
    def update
      @project = Project.find(params[:id])
      if @project.update(project_params)
        redirect_to edit_admin_project_url(@project), notice: 'Project was successfully updated.'
      else
        render 'edit'
      end
    end
    private
    def project_params
      params.require(:project).permit(:name, :description, :since, :till, :team_size, :url, upload_files_attributes: [:filename, :id])
    end
  end
end
