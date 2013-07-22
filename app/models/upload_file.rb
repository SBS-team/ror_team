# == Schema Information
#
# Table name: upload_files
#
#  id            :integer          not null, primary key
#  filename      :string(255)
#  fileable_id   :integer
#  fileable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  img_name      :string(255)
#

class UploadFile < ActiveRecord::Base
  belongs_to :fileable, :polymorphic => true

  mount_uploader :filename, FileUploader
  mount_uploader :img_name, ImageUploader

end
