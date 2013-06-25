ActiveAdmin.register Category do
  index do
    column :id
    column :name
    column :created_at
    default_actions
  end
  controller do
    def create
      begin
        @category = Category.new(category_params)
        @category.save!
        redirect_to admin_category_url(@category), notice: 'Post was successfully created.'
      rescue Exception => e
        logger.error(e.message)
        render 'new'
      end
    end
    private
    def category_params
      params.require(:category).permit(:name)
    end
  end
end