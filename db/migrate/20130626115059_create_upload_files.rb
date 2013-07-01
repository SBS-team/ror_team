class CreateUploadFiles < ActiveRecord::Migration
  def change
    create_table :upload_files do |t|
      t.string :filename
      t.integer :fileable_id
      t.string :fileable_type

      t.timestamps
    end
  end
end
