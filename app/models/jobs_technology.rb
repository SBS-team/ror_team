# == Schema Information
#
# Table name: jobs_technologies
#
#  id            :integer          not null, primary key
#  job_id        :integer
#  technology_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class JobsTechnology < ActiveRecord::Base

  belongs_to :job
  belongs_to :technology

  validates :job_id, presence: true, numericality: {only_integer: true, greater_then: 0}
  validates :technology_id, presence: true, numericality: {only_integer: true, greater_then: 0}

end
