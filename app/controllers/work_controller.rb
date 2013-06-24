class WorkController < ApplicationController
  def index
    @projects = Project.all.preload(:technologies).page params[:page]
    @post = Post.all.order("created_at DESC").limit(4)
    @jobs = Job.all.order("created_at DESC").limit(4)
  end
end
