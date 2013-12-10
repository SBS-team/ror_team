module ApplicationHelper

  def nav_link_to(link_text, link_path, controller_name)
    content_tag :li, class: (controller.controller_name == controller_name.to_s ? 'active' : '') do
      link_to link_text, link_path
    end
  end

  def get_section_bkg_image_url(all, name)
    section = all.select{|x| x.name.eql?(name)}.first
    section.blank? ? asset_path('team_section_bkg.jpg') : section.image_url
  end

end