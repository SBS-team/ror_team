ActiveAdmin.register Technology do

  new do
    column :id
    column :name
    column :technology_category
    default_actions
  end

  form do |f|
    f.semantic_errors :base
    f.inputs do
      f.input :name
      f.input :technology_category
      # f.input :project_technology_category
    end
    f.buttons
  end

  controller do
    def create
      begin
        tech_cat = TechnologyCategory.find(params[:technology][:technology_category_id])
        @tech = tech_cat.technologies.create!(safe_params)
        redirect_to edit_admin_technology_url(@tech), notice: 'Technology was successfully created.'
      rescue Exception => e
        logger.error(e.message)
        render 'new'
      end
    end
    def update
      @tech = Technology.find(params[:id])
      if @tech.update(safe_params)
        redirect_to edit_admin_technology_url(@tech), notice: 'Technology was successfully updated.'
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

__END__

{"utf8"=>"✓",
 "authenticity_token"=>"lAb52PYiOUzmWwl0DP9ShQ3jjB9ryUVJIC8RaQPDs5I=",
 "technology"=>
  {"name"=>"name",
   "technology_category_id"=>"8",
   "project_technology_category_id"=>"8"},
 "commit"=>"Create Technology",
 "action"=>"create",
 "controller"=>"admin/technologies"}