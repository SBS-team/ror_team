# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Service < ActiveRecord::Base

  has_many :project_services, dependent: :destroy
  has_many :projects, through: :project_services
  has_one :upload_file, as: :fileable, dependent: :destroy

  accepts_nested_attributes_for :upload_file

  validates :name, presence: true, uniqueness: true, length: {in: 5..45}
  validates :upload_file, presence: true

end
