class Project < ActiveRecord::Base
  has_many :project_services
  has_many :services, through: :project_services
  has_many :project_technology_categories
end
