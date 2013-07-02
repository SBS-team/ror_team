class HomeController < ApplicationController

  before_filter :last_posts_and_jobs , :only => :index

  def index
    @tech = Technology.order("random()").limit(8)
    @some_projects = Project.order("random()").limit(8)

  end

end
