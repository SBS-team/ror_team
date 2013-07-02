class TeamController < ApplicationController

  before_filter :last_posts_and_jobs , :only => :index

  def index
    @team_member = Post.all
  end

  def show
    #@team_member = User.all
  end

end
