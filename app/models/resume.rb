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
#

class Resume < ActiveRecord::Base

  belongs_to :job
  has_one :upload_file, :as => :fileable, :dependent => :destroy
  accepts_nested_attributes_for :upload_file

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
            :length => {:maximum => 50},
            :format => {:with => /\A[+]?\d+\Z/}
  validate :validate_data

  private

  def validate_data
    if (self.upload_file.blank?)
      errors.add(:description, "can't be blank and file is not attached") if self.description.blank?
    end
  end
end
