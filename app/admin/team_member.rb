ActiveAdmin.register TeamMember do

  menu parent: 'Team', priority: 0

  filter :name, as: :string

  index do
    selectable_column
    column :image do |member|
      image_tag(member.image_url(:thumb), height: 30)
    end
    column :name
    column :last_name
    default_actions
  end

  show do |member|
    panel 'Team Member Details' do
      attributes_table_for member do
        row :image do |member|
          image_tag(member.image_url(:thumb))
        end
        row :name
        row :last_name
        row :team_role
        row :created_at
        row :updated_at
      end
    end
  end

  form do |f|
    f.inputs 'Team Member Details' do
      f.input :name
      f.input :last_name
      f.input :team_role
      f.inputs for: [:upload_file, f.object.upload_file || UploadFile.new] do |file|
        file.input :img_name, as: :file,
                   hint: file.object.img_name.nil? ? file.template.content_tag(:span, 'no map yet') : file.template.image_tag(file.object.img_name.url(:thumb))
        file.input :remote_img_name_url, as: :url
      end
    end
    f.actions
  end

  permit_params :name, :last_name, :team_role_id, upload_file_attributes: [:img_name, :id]

  controller do
    def scoped_collection
      TeamMember.includes([:upload_file]).page(params[:page]).per(30)
    end
  end

end