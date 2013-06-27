class WorkController < ApplicationController
  def index
    @projects = Project.all.preload(:technologies).page params[:page]
  end
end
