class TeamMember < ActiveRecord::Base

  belongs_to :team_role
  has_one :upload_file, as: :fileable, dependent: :destroy

  accepts_nested_attributes_for :team_role, :upload_file


  def image_url(thumb={})
    if upload_file.blank? || upload_file.img_name.nil?
      'no_image.gif'
    else
      upload_file.img_name.url(thumb)
    end
  end

end