ActiveAdmin.register Category do

  menu :parent => 'Blog'

  filter :name, :as => :string

  index do
    selectable_column
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

    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        redirect_to admin_category_url(@category), notice: 'Category was successfully updated.'
      else
        render :edit, notice: 'Error has occurred while updating.'
      end
    end

    private
    def category_params
      params.require(:category).permit(:name)
    end

  end

end