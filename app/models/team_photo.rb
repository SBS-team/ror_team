# == Schema Information
#
# Table name: team_photos
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TeamPhoto < ActiveRecord::Base

  has_many :upload_files, as: :fileable, dependent: :destroy

  accepts_nested_attributes_for :upload_files

  validates :title, presence: true, uniqueness: true, length: {in: 5..100}
  validates :upload_files, presence: true

end
