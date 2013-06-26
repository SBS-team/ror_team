class ContactController < ApplicationController
  before_filter :submit_form

  def new
    @services = Service.all
    @tech_categories = TechnologyCategory.all
  end

  def create

  end

  def submit_form
    @message = params
    @guest_name = params[:name]
    if params[:commit]
      if @guest_name.nil? || @guest_name.empty?
        flash[:error] = 'Name cannot be blank'
      end
    end
    @guest_email = params[:email]
    if params[:commit]
      if @guest_email.nil? || @guest_email.empty?
        flash[:error] = 'Email cannot be blank'
      end
    end
    @guest_phone = params[:phone]
    @guest_text = params[:text]
    @service_type = params[:service_type]
    @work_type = params[:work_type]
  end

end
