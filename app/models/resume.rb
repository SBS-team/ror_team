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
  has_one :upload_file, as: :fileable, dependent: :destroy

  accepts_nested_attributes_for :upload_file, reject_if: lambda { |a| a[:filename].blank? }, allow_destroy: true

  validates :description, length: {maximum: 3000}
  validates :job_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :name, presence: true, length: {minimum: 4, maximum: 40}
  validates :email, presence: true, format: {with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}
  validate :validate_data
  validate :file_size

  private
  def validate_data
    if (self.upload_file.blank?)
      errors.add(:description, "can't be blank and file is not attached") if self.description.blank?
    else
      if (/\.doc|\.pdf/ =~ self.upload_file.filename.to_s).nil?
        errors.add(:upload_file, 'not doc, pdf types')
      end
    end
  end

  def file_size
    unless self.upload_file.nil? || self.upload_file.filename.file.nil?
      if !self.upload_file.filename.file.nil? && self.upload_file.filename.file.size.to_f/(1000*1000) > 5
        errors.add(:file, 'You cannot upload a file greater than 5 MB')
      end
    end
  end

end