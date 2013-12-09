class Advantage < ActiveRecord::Base

  has_one :upload_file, as: :fileable, dependent: :destroy

  accepts_nested_attributes_for :upload_file

  validates :description, presence: true, length: {minimum: 3, maximum: 255}

end
