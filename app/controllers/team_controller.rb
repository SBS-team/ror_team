class TeamController < ApplicationController

  def index
    @team_member = User.all
  end

end
