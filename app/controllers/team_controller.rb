class TeamController < ApplicationController

  before_filter :last_posts_and_jobs , only: [:index , :show]

  def index
    unless params[:role].blank?
      @team = AdminUser.not_admin.where('role = :role', role: params[:role]).includes(:upload_file).page(params[:page]).per(5)
    else
      @team = AdminUser.where.not(role: 'admin').includes(:upload_file).order('role').page(params[:page]).per(5)
    end
    @team_photo = TeamPhoto.includes(:upload_files).order('random()').take
  end

  def show
    @team = AdminUser.not_admin.find(params[:id])
    @fullteam = AdminUser.where.not(role: 'admin')
  end

end
