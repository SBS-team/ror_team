ActiveAdmin.register TechnologyCategory do
  index do
    column :id
    column :name
    default_actions
  end

  form do |f|
    f.semantic_errors :base
    f.inputs do
      f.input :name
    end
    f.buttons
  end

  controller do
    def create
      begin
        @tech_cat = TechnologyCategory.new(safe_params)
        @tech_cat.save!
        redirect_to edit_admin_technology_category_url(@tech_cat)
      rescue Exception => e
        logger.error(e.message)
        render 'new'
      end
    end
    def update
      @tech_cat = TechnologyCategory.find(params[:id])
      if @tech_cat.update(safe_params)
        redirect_to edit_admin_technology_category_url(@tech_cat), notice: 'Project Category was successfully updated.'
      else
        render 'edit'
      end
    end
    private
    def safe_params
      params.require(:technology_category).permit(:name)
    end
  end
end
