class CareersController < ApplicationController
  def index
    @jobs = Job.all
  end
end
