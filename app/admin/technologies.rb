ActiveAdmin.register Technology do
  controller do
    def create
      begin
        @tech = Technology.new(safe_params)
        @tech.save!
        redirect_to admin_project_url(@tech)
      rescue Exception => e
        logger.error(e.message)
        render 'new'
      end
    end
    def update
      @tech = Technology.find(params[:id])
      if @tech.update(safe_params)
        redirect_to edit_admin_project_url(@tech), notice: 'Technology was successfully updated.'
      else
        render 'edit'
      end
    end
    private
    def safe_params
      params.require(:technology).permit(:name)
    end
  end
end
