class Service < ActiveRecord::Base
  has_many :project_services
  has_many :projects, through: :project_services
end
