ActiveAdmin.register Resume do

  menu :parent => 'Careers'

  filter :name, :as => :string
  filter :email, :as => :string
  filter :job, :as => :check_boxes
  filter :created_at

  index do
    selectable_column
    column :name
    column :email
    column :phone
    column :description
    column :created_at
    column :upload_file do |resume|
      unless resume.upload_file.blank?
        link_to resume.upload_file.filename.to_s.rpartition('/')[2], (root_url.to_s + resume.upload_file.filename.url[1..-1])
      end
    end
    default_actions
  end

  controller do

    def scoped_collection
      Resume.includes([:upload_file]).page(params[:page]).per(30)
    end

  end

end