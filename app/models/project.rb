# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  since       :date
#  team_size   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Project < ActiveRecord::Base
  has_many :project_services
  has_many :services, through: :project_services

  has_many :project_technology_categories, dependent: :destroy
  has_many :technologies, through: :project_technology_categories

  # accepts_nested_attributes_for :project_technology_categories, allow_destroy: true
end
