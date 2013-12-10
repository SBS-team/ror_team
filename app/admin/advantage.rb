ActiveAdmin.register Advantage do

  filter :description, as: :string

  index do
    selectable_column
    column :image do |adv|
      unless adv.upload_file.blank?
        image_tag(adv.upload_file.img_name.url(:thumb), width: 50, height: 50 )
      end
    end
    column :description
    column :created_at
    default_actions
  end

  show do
    panel 'Advantage Details' do
      attributes_table_for advantage do
        row :image do |adv|
          unless adv.upload_file.blank?
            image_tag(adv.upload_file.img_name.url(:thumb))
          end
        end
        row :description
      end
    end
  end

  form html: {enctype: 'multipart/form-data'} do |f|
    f.semantic_errors :base
    f.inputs 'Advantage', multipart: true do
      f.input :description, as: :text
      f.inputs for: [:upload_file, f.object.upload_file || UploadFile.new] do |file|
        file.input :img_name, as: :file, hint: file.object.img_name.nil? ? f.template.content_tag(:span, 'no map yet') : file.template.image_tag(file.object.img_name.url(:thumb))
        file.input :remote_img_name_url, as: :url
      end
    end
    f.actions
  end

  controller do
    def create
      @advantage = Advantage.new(advantage_params)
      if @advantage.save
        redirect_to admin_advantage_url(@advantage), notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    def update
      @advantage = Advantage.find(params[:id])
      if @advantage.update(advantage_params)
        redirect_to admin_advantage_url(@advantage), notice: 'Category was successfully updated.'
      else
        render :edit, notice: 'Error has occurred while updating.'
      end
    end

    private
    def advantage_params
      params.require(:advantage).permit(:id, :description, upload_file_attributes: [:img_name, :id])
    end
  end

end