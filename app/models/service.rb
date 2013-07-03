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
  has_many :upload_files, :as => :fileable
  accepts_nested_attributes_for :upload_files
  validates :name,
            :presence => true,
            :uniqueness => true,
            :length => { :in => 5..45 }
  validates :upload_files,
            :presence => true
end
