class CreateProjectTechnologyCategories < ActiveRecord::Migration
  def change
    create_table :project_technology_categories do |t|
      t.integer :project_id
      t.integer :technology_id
      t.timestamps
    end
  end
end