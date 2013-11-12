class ResumeController < ApplicationController

  def new
    @resume = Resume.new
  end

  def create
    @resume = Resume.new(params[:resume])
    if @resume.save

    end
  end

end
