ActiveAdmin.register Resume do

  index do
    column :name
    column :email
    column :phone
    column :description
    column :created_at
    column :upload_files do |resume|
      link_to resume.upload_files.first.filename.to_s.rpartition('/')[2], (root_url.to_s + resume.upload_files.first.filename.url[1..-1])
    end

    default_actions
  end

end