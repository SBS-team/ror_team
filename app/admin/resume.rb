ActiveAdmin.register Resume do

  filter :name
  filter :job, :as => :check_boxes
  filter :created_at

  index do
    column :name
    column :email
    column :phone
    column :description
    column :created_at
    column :upload_files do |resume|
      unless resume.upload_files.blank?
        link_to resume.upload_files.first.filename.to_s.rpartition('/')[2], (root_url.to_s + resume.upload_files.first.filename.url[1..-1])
      end
    end

    default_actions
  end

end