class CompanyController < ApplicationController

  before_filter :new_posts_and_jobs

  include ApplicationHelper

  def index
    @technology_categories = TechnologyCategory.all
    @services = Service.all
  end
end
