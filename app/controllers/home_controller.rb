class HomeController < ApplicationController

  before_action :last_posts_and_jobs , only: :index

  def index
    @message = Message.new
    @projects = Project.includes(:upload_files).order('random()').limit(8)
    @jobs = Job.includes(technologies: :upload_file).order('created_at DESC')
    @testimonials = ClientTestimonial.order('random()').limit(6)
    @team = TeamMember.includes(:team_role)
    @team_roles = TeamRole.all
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, notice: t('.contact_sent_msg'))
    else
      flash.now[:error] = @message.errors.full_messages.join(', ')
      redirect_to :back
    end
  end

end
