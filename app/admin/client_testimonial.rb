ActiveAdmin.register ClientTestimonial do

  permit_params :comment_text, :author_name, :author_position, :project_id

  index do
    selectable_column
    column :author_name
    column :author_position
    column :comment_text do |ct|
      truncate(ct.comment_text, length: 100)
    end
    column "Project" do |ct|
      link_to ct.project.name, admin_project_path(ct.project.id)
    end
    column :created_at
    column :updated_at
    default_actions
  end

end