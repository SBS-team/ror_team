# == Schema Information
#
# Table name: resumes
#
#  id          :integer          not null, primary key
#  description :text
#  job_id      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#  email       :string(255)
#  phone       :string(255)
#  file        :string(255)
#

class Resume < ActiveRecord::Base

  belongs_to :job
  has_many :upload_files, :as => :fileable

  validates :description,
            :length => {:maximum => 3000}
  validates :job_id,
            :presence => true,
            :numericality => { :only_integer => true, :greater_than => 0 }
  validates :name,
            :presence => true,
            :length => { :minimum => 2, :maximum => 40 }
  validates :email,
            :presence => true,
            :format => {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}
  validates :phone,
            :presence => true,
            :length => {:maximum => 50}
end
