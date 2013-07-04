class TeamController < ApplicationController

  before_filter :last_posts_and_jobs , :only => :index

  def index
    @team = AdminUser.where.not(:role => 'admin').page(params[:page]).per(5)
  end

  def show
    @team = AdminUser.find(params[:id])
  end


  private
  def admin_user_params
    params.require(:admin_user).permit(:email,:role,:fio,:about, upload_files_attributes: [:filename, :id])
  end
end
