class ProjectTechnologyCategory < ActiveRecord::Base
  belongs_to :project
  belongs_to :technology

  validates :project_id,
            :presence => true,
            :numericality => {  :only_integer => true,
                                :greater_then => 0 }
  validates :technology_id,
            :presence => true,
            :numericality => {  :only_integer => true,
                                :greater_then => 0 }
end
