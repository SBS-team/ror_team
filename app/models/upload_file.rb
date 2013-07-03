class UploadFile < ActiveRecord::Base
  belongs_to :fileable, :polymorphic => true
  mount_uploader :filename, FileUploader

  validates :filename, :presence => true
end
