# == Schema Information
#
# Table name: project_services
#
#  id         :integer          not null, primary key
#  project_id :integer
#  service_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class ProjectService < ActiveRecord::Base

  belongs_to :project
  belongs_to :service

  validates :project_id, presence: true, numericality: {only_integer: true, greater_then: 0}
  validates :service_id, presence: true, numericality: {only_integer: true, greater_then: 0}

end
