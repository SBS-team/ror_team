# == Schema Information
#
# Table name: technologies
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  technology_category_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class Technology < ActiveRecord::Base

  belongs_to :technology_category
  has_many :project_technology_categories, dependent: :destroy
  has_many :projects, through: :project_technology_categories
  has_one :upload_file, as: :fileable, dependent: :destroy
  has_many :job_technologies, dependent: :destroy
  has_many :jobs, through: :job_technologies

  accepts_nested_attributes_for :upload_file
  accepts_nested_attributes_for :job_technologies, allow_destroy: true

  validates :name, presence: true, uniqueness: true, length: {in: 1..45}
  validates :technology_category_id, presence: true, numericality: {only_integer: true, greater_then: 0}

end
