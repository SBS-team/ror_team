module ApplicationHelper

  def nav_link_to(link_text, link_path, checks=nil)
    active = false
    if not checks.nil?
      active = true
      checks.each do |check,v|
        if not v.include? params[check]
          active = false
          break
        end
      end
    end

    return content_tag :li, :class => (active ? 'active' : '') do
      link_to link_text, link_path
    end
  end

  def special_controller?(checks=nil)
    special = false
    unless checks.nil?
      special = true
      checks.each do |check,v|
        unless v.include? params[check]
          special = false
          break
        end
      end
    end

    return special
  end

end