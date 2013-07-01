class CompanyController < ApplicationController

  before_filter :last_posts_and_jobs , :only => :index

  def index
    @technology_categories = TechnologyCategory.all
    @services = Service.all
  end
end
