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

  accepts_nested_attributes_for :upload_file

  validates :title, presence: true
  validates :description, presence: true

end
