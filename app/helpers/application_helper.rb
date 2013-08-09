module ApplicationHelper

  def nav_link_to(link_text, link_path, controller_name)
    return content_tag :li, :class => (    controller.controller_name == controller_name.to_s ? 'active' : '') do
      link_to link_text, link_path
    end
  end
end