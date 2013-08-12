class CompanyController < ApplicationController

  before_filter :last_posts_and_jobs , :only => :index

  def index
    @technology_categories = TechnologyCategory.includes(:technologies => :upload_file)
    @services = Service.includes(:upload_file)
  end
end
