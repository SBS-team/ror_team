ActiveAdmin.register TechnologyCategory do

  menu :parent => 'Skills & Service'

  filter :name

  index do
    selectable_column
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
        redirect_to admin_technology_category_path(@tech_cat), notice: 'Technology Category was successfully created.'
      else
        render :new, notice: 'Data of Technology Category was invalid. Try more'
      end
    end

    def update
      @tech_cat = TechnologyCategory.find(params[:id])
      if @tech_cat.update(safe_params)
        redirect_to admin_technology_category_path(@tech_cat), notice: 'Technology Category was successfully updated.'
      else
        render :edit, notice: 'Data of Technology Category was invalid. Try more'
      end
    end

    private
    def safe_params
      params.require(:technology_category).permit(:name)
    end
  end
end
