class JobsTechnology < ActiveRecord::Base

  belongs_to :job
  belongs_to :technology

  validates :job_id, presence: true, numericality: {only_integer: true, greater_then: 0}
  validates :technology_id, presence: true, numericality: {only_integer: true, greater_then: 0}

end
