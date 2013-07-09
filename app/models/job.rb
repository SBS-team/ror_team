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

  has_many :resumes ,:dependent => :destroy

  validates :title,
            :presence => true
  validates :description,
            :presence => true
end
