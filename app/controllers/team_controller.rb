class TeamController < ApplicationController

  before_filter :last_posts_and_jobs , only: [:index , :show]

  def index
    if !params[:role].blank?
      @team = AdminUser.where("role = :role", :role => params[:role]).page(params[:page]).per(5)
    else
      @team = AdminUser.where.not(:role => 'admin').page(params[:page]).per(5)
    end
  end

  def show
    @team = AdminUser.find(params[:id])
    @fullteam = AdminUser.where.not(:role => 'admin')
  end


  private
  def admin_user_params
    params.require(:admin_user).permit(:first_name, :last_name, :email, :role, :about, upload_files_attributes: [:filename, :id])
  end
end
