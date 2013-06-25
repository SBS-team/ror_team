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

  validates :decription,
            :presence => true,
            :length => { :minimum => 5, :maximum => 1000 }
=begin раскоментировать, когда разберемся с юзерами
  validates :user_id,
            :presence => true,
            :numericality => { :only_integer => true, :greater_than => 0 }
=end
  validates :job_id,
            :presence => true,
            :numericality => { :only_integer => true, :greater_than => 0 }
  validates :name,
            :presence => true,
            :length => { :minimum => 2, :maximum => 30 }
  validates :email,
            :format => {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}
  validates :phone,
            :presence => true
end
