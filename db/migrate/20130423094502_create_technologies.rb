class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :name, limit: 255
      t.integer :technology_category_id
      t.integer :project_technology_category_id

      t.timestamps
    end
  end
end
