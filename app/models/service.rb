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

  validates :name,
            :presence => true,
            :uniqueness => true,
            :length => { :in => 5..45 }
end
