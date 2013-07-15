class AddImgNameToUploadFile < ActiveRecord::Migration
  def change
    add_column  :upload_files, :img_name, :string
  end
end
