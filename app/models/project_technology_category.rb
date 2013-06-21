# == Schema Information
#
# Table name: project_technology_categories
#
#  id            :integer          not null, primary key
#  project_id    :integer
#  created_at    :datetime
#  updated_at    :datetime
#  technology_id :integer
#

class ProjectTechnologyCategory < ActiveRecord::Base
  belongs_to :project
  belongs_to :technology
end
