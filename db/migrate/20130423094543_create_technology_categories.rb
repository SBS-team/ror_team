class CreateTechnologyCategories < ActiveRecord::Migration
  def change
    create_table :technology_categories do |t|
      t.string :name, limit: 255
      t.timestamps
    end
  end
end