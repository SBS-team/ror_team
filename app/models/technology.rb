class Technology < ActiveRecord::Base
  belongs_to :project_technology_category
  belongs_to :technology_category
end
