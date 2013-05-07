class AddTechnologyIdToProjectTechnologyProject < ActiveRecord::Migration
  def change
    add_column :project_technology_categories, :technology_id, :integer
  end
end
