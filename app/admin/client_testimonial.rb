ActiveAdmin.register ClientTestimonial do

  #menu parent: 'Project'

  #filter :comment_text, as: :string
  #filter :author_name, as: :string
  #filter :author_position, as: :string
  #
  index do
    selectable_column
    column :author_name
    column :author_position
    column :comment_text do |ct|
      truncate(ct.comment_text, length: 100)
    end
    column "Project" do |ct|
      link_to ct.project.name, admin_project_path(ct.project.id)
    end
    default_actions
  end

  controller do

    def new
      @testimonial ||= ClientTestimonial.new
    end

    def create
      @testimonial = ClientTestimonial.new(client_testimonial_params)
      if @testimonial.save
        redirect_to admin_client_testimonial_url(@category), notice: 'Testimonial was successfully created.'
      else
        render :new
      end
    end

    def update
      @testimonial = ClientTestimonial.find(params[:id])
      if @testimonial.update(client_testimonial_params)
        redirect_to admin_client_testimonial_url(@testimonial), notice: 'Testimonial was successfully updated.'
      else
        render :edit, notice: 'Error has occurred while updating.'
      end
    end

    private
    def client_testimonial_params
      params.require(:client_testimonial).permit(:comment_text, :author_name, :author_position, :project_id)
    end
  end
end