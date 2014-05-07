# == Schema Information
#
# Table name: team_members
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  last_name    :string(255)
#  team_role_id :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class TeamMember < ActiveRecord::Base

  belongs_to :team_role
  has_one :upload_file, as: :fileable, dependent: :destroy

  accepts_nested_attributes_for :team_role, :upload_file

  validates :name, presence: true, length: {in: 2..50}
  validates :last_name, presence: true, length: {in: 2..50}
  validates :team_role_id, presence: true, numericality: {only_integer: true, greater_then: 0}

  def image_url(thumb={})
    if upload_file.blank? || upload_file.img_name.blank?
      'team_member_no_image.png'
    else
      upload_file.img_name.url(thumb)
    end
  end

end
