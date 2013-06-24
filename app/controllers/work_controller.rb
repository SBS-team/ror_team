class WorkController < ApplicationController
  def index
    @projects = Project.all.preload(:technologies)
    @post = Post.all.order("created_at DESC").limit(4)
  end
end
