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
  belongs_to :user
  belongs_to :job
  has_many :upload_files, :as => :fileable
  accepts_nested_attributes_for :upload_files

  validates :description,
            :presence => true,
            :length => { :minimum => 5, :maximum => 1000 }
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
