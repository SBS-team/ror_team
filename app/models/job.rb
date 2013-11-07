# == Schema Information
#
# Table name: jobs
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Job < ActiveRecord::Base

  has_many :resumes, dependent: :destroy
  has_one  :upload_file, as: :fileable, dependent: :destroy
  has_many :jobs_technologies, dependent: :destroy
  has_many :technologies, through: :jobs_technologies

  accepts_nested_attributes_for :upload_file
  accepts_nested_attributes_for :jobs_technologies, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true

end
