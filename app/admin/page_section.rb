ActiveAdmin.register PageSection do

  show do |section|
    panel 'Page Section Details' do
      attributes_table_for section do
        row :image do |section|
          image_tag section.image_url, height: 700
        end
        row :name
        row :description
        row :created_at
        row :updated_at
      end
    end
  end

  permit_params :name, :description, upload_file_attributes: [:bkg_image, :id]

  form do |f|
    f.inputs 'Page Section Details' do
      f.input :name
      f.input :description
      f.inputs for: [:upload_file, f.object.upload_file || UploadFile.new] do |file|
        file.input :bkg_image, as: :file,
                   hint: file.object.bkg_image.nil? ? file.template.content_tag(:span, 'no map yet') : file.template.image_tag(file.object.bkg_image.url, width: 600)
        file.input :remote_bkg_image_url, as: :url
      end
    end
    f.actions
  end

end