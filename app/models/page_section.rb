class PageSection < ActiveRecord::Base

  has_one :upload_file, as: :fileable, dependent: :destroy

  accepts_nested_attributes_for :upload_file

  def image_url
    if upload_file.blank? || upload_file.bkg_image.nil?
      'no_image.gif'
    else
      upload_file.bkg_image.url
    end
  end

end