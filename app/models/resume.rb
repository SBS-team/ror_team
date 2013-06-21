# == Schema Information
#
# Table name: resumes
#
#  id         :integer          not null, primary key
#  decription :text
#  job_id     :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Resume < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
end
