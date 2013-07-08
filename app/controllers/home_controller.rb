class HomeController < ApplicationController

  before_action :last_posts_and_jobs , only: :index

  def index
    @technologies = Technology.order('random()').limit(8)
    @projects = Project.order('random()').limit(8)
  end

end
