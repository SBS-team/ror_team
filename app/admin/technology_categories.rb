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
    f.actions
  end

  controller do
    def create
      @tech_cat = TechnologyCategory.new(safe_params)
      if  @tech_cat.save
        redirect_to edit_admin_technology_category_url(@tech_cat), notice: 'Technology Category was successfully created.'
      else
        render :new
      end
    end
    def update
      @tech_cat = TechnologyCategory.find(params[:id])
      if @tech_cat.update(safe_params)
        redirect_to edit_admin_technology_category_url(@tech_cat), notice: 'Technology Category was successfully updated.'
      else
        render :edit
      end
    end

    private
    def safe_params
      params.require(:technology_category).permit(:name)
    end
  end
end
