class RemoveProjectTechnologyCategoryIdFromTechnologies < ActiveRecord::Migration
  def change
    remove_column :technologies, :project_technology_category_id
  end
end
