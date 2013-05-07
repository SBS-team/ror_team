ActiveAdmin.register Post do

  # Customize columns displayed on the index screen in the table
  index do
    column :id
    column :title
    column :tag_list, sortable: false
    column "Author" do |post|
      post.admin.email
    end
    column :created_at
    default_actions
  end

  #show
  show do
    h1 post.title
    div do
      simple_format post.description
      post.tag_list
    end
  end

  form do |f|
    f.semantic_errors :base
    f.inputs "Post Details" do
      f.input :title
      f.input :description, as: :html_editor
      f.input :tag_list, :hint => 'Comma separated'
    end
    f.buttons
  end

  controller do
    def create
      begin
        @post = current_admin_user.posts.build(post_params)
        @post.save!
        redirect_to admin_post_url(@post), notice: 'Post was successfully created.'
      rescue Exception => e
        logger.error(e.message)
        render 'new'
      end
    end
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to edit_admin_post_url(@post), notice: 'Post was successfully updated.'
      else
        render 'edit'
      end
    end
    def tag_cloud
      @tags = Post.tag_counts_on(:tags)
    end
    private
    def post_params
      params.require(:post).permit(:title, :description, :tag_list)
    end
  end
end