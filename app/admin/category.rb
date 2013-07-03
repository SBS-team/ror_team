ActiveAdmin.register Category do
  index do
    column :id
    column :name
    column :created_at
    default_actions
  end

  controller do
    def create
        @category = Category.new(category_params)
      if @category.save
        redirect_to admin_category_url(@category), notice: 'Category was successfully created.'
       else
        render :new
      end
    end

    private
    def category_params
      params.require(:category).permit(:name)
    end
  end
end