class ProjectTechnologyCategory < ActiveRecord::Base
  belongs_to :project
  has_many :technologies
end
