class CreatePageSections < ActiveRecord::Migration
  def change
    create_table :page_sections do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    add_column :upload_files, :bkg_image, :string
  end
end