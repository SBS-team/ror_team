# == Schema Information
#
# Table name: technologies
#
#  id                             :integer          not null, primary key
#  name                           :string(255)
#  technology_category_id         :integer
#  project_technology_category_id :integer
#  created_at                     :datetime
#  updated_at                     :datetime
#

class Technology < ActiveRecord::Base
  belongs_to :technology_category
  has_many :project_technology_categories
  has_many :projects, through: :project_technology_categories
end
