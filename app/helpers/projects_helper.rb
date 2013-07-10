module ProjectsHelper

  def technologies_inject(project)
    project.technologies.inject({}) { |res, elem| res[elem.technology_category.name] ||= []; res[elem.technology_category.name].push(elem.name); res  }
  end

end