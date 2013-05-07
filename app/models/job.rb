class Job < ActiveRecord::Base
  has_many :resumes
  has_many :users, through: :resumes
end
