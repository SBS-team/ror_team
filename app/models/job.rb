# annotate
class Job < ActiveRecord::Base

  has_many :resumes
  has_many :users, through: :resumes

  validates :title,
            :presence => true,
            :length => { :minimum => 3, :maximum => 45 }
  validates :description,
            :presence => true,
            :length => { :minimum => 5, :maximum => 1000 }

end
