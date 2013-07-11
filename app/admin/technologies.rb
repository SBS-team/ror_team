ActiveAdmin.register Technology do

  index do
    column :id
    column :name
    column :technology_category
    default_actions
  end

  form :html => {:enctype => "multipart/form-data" } do |f|
    f.semantic_errors :base
    f.inputs 'Technology', :multipart => true do
      f.input :name
      f.input :technology_category
      f.has_many :upload_files do |file|
        file.input :img_name, :as => :file, :label => 'Image', :hint => file.template.image_tag(file.object.img_name.url)
        file.input :id, :as => :hidden
      end
    end
    f.actions
  end

  controller do
    def create
      tech_cat = TechnologyCategory.find(params[:technology][:technology_category_id])
       if @tech = tech_cat.technologies.create(safe_params)
        redirect_to admin_technology_url(@tech), notice: 'Technology was successfully created.'
      else
        render :new
      end
    end
    def update
      @tech = Technology.find(params[:id])
      if @tech.update(safe_params)
        redirect_to admin_technology_url(@tech), notice: 'Technology was successfully updated.'
      else
        render :edit
      end
    end
    private
    def safe_params
      params.require(:technology).permit(:name, :technology_category_id, upload_files_attributes: [:img_name, :id])
    end
  end
end