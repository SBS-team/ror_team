ActiveAdmin.register TeamPhoto do

  filter :title

  index do
    selectable_column
    column :title
    column :created_at
    default_actions
  end

  show do
    panel 'Post Details' do
      attributes_table_for team_photo do
        row :title
        unless team_photo.upload_files.blank?
          team_photo.upload_files.each do |photo|
            row :photo do
              image_tag(photo.img_name.url(:thumb))
            end
          end
        end
        row :created_at
      end
    end
  end

  form :html => {:enctype => "multipart/form-data" } do |f|
    f.semantic_errors :base
    f.inputs 'Team Photo'do
      f.input :title
      f.has_many :upload_files do |file|
        file.input :img_name, :as => :file, :hint => file.object.img_name.nil? ? f.template.content_tag(:span, "no map yet") : file.template.image_tag(file.object.img_name.url(:thumb))
        file.input :remove_img_name, :as => :boolean , :label => 'Delete image?'
        file.input :id, :as => :hidden
      end
    end
    f.actions
  end

  controller do
    def create
      @team_photo = TeamPhoto.new(team_photo_params)
      if @team_photo.save
        redirect_to admin_team_photo_url(@team_photo), notice: 'Post was successfully created.'
      else
        render :new, notice: 'Error has occurred while creating.'
      end
    end

    def update
      @team_photo = TeamPhoto.find(params[:id])
      if @team_photo.update(team_photo_params)
        unless params[:team_photo][:upload_files_attributes].blank?
          params[:team_photo][:upload_files_attributes].each_value do |file|
            if file[:remove_img_name].to_i == 1
              UploadFile.find(file[:id]).destroy
            end
          end
        end
        redirect_to admin_team_photo_url(@team_photo), notice: 'Post was successfully updated.'
      else
        render :edit, notice: 'Error has occurred while updating.'
      end
    end

    private
    def team_photo_params
      params.require(:team_photo).permit(:title, upload_files_attributes: [:img_name, :id, :remove_img_name])
    end
  end

end