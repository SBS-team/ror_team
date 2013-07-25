ActiveAdmin.register Technology do

  filter :name
  filter :technology_category, :as => :check_boxes
  filter :projects

  index do
    selectable_column
    column :image do |technology|
      unless technology.upload_file.blank?
        image_tag(technology.upload_file.img_name.url(:thumb), width: 50, height: 50 )
      end
    end
    column :name
    column :technology_category
    default_actions
  end

  show do
    panel 'Post Details' do
      attributes_table_for technology do
        row :image do |technology|
          unless technology.upload_file.blank?
            image_tag(technology.upload_file.img_name.url(:thumb))
          end
        end
        row :name
        row :technology_category
      end
    end
  end

  form :html => {:enctype => "multipart/form-data" } do |f|
    f.semantic_errors :base
    f.inputs 'Technology', :multipart => true do
      f.input :name
      f.input :technology_category
      f.inputs :for => [:upload_file, f.object.upload_file || UploadFile.new] do |file|
        file.input :img_name, :as => :file, :hint => file.object.img_name.nil? ? f.template.content_tag(:span, "no map yet") : file.template.image_tag(file.object.img_name.url(:thumb))
        file.input :remote_img_name_url, :as => :url
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
      params.require(:technology).permit(:name, :technology_category_id, upload_file_attributes: [:img_name, :id])
    end
  end

end