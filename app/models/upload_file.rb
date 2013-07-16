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
#

class UploadFile < ActiveRecord::Base
  belongs_to :fileable, :polymorphic => true

  before_update :check_if_not_exist

  mount_uploader :filename, FileUploader
  mount_uploader :img_name, ImageUploader

  private
  def check_if_not_exist
    if UploadFile.where("img_name = '#{self.filename.to_s.rpartition('/')[2]}' AND fileable_type = '#{self.fileable_type.to_s}' ").count > 1
      ImageUploader.configure do |config|
        config.remove_previously_stored_files_after_update = false
      end
    end
  end

end
