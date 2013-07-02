class TeamController < ApplicationController

  before_filter :last_posts_and_jobs , :only => :index

  def index
    @team_member = AdminUser.where.not(role: "admin").page(params[:page]).per(5)
  end

  def show
    #@team_member = User.all
  end

end
