class Technology < ActiveRecord::Base
  belongs_to :technology_category
  has_many :project_technology_categories
  has_many :projects, through: :project_technology_categories
end
