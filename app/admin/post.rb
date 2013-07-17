ActiveAdmin.register Post do

  filter :categories

  # Customize columns displayed on the new screen in the table
  index do
    selectable_column
    column :image do |post|
      unless post.upload_file.blank?
        image_tag(post.upload_file.img_name.url(:thumb), width: 50, height: 50 )
      end
    end
    column :title do |post|
      link_to post.title, admin_post_path(post)
    end
    column :tag_list, sortable: false
    column :categories do |category|
      category.categories.collect(&:name).join(', ')
    end
    column 'Author' do |post|
      link_to post.admin.email, admin_admin_user_path(post.admin)
    end
    column :created_at
    default_actions
  end

  show do
    panel 'Post Details' do
      attributes_table_for post do
        row :image do |post|
          unless post.upload_file.blank?
            image_tag(post.upload_file.img_name.url(:thumb))
          end
        end
        row :title
        row :description
        row :tag_list, sortable: false
        row :categories do |category|
          category.categories.collect(&:name).join(', ')
        end
        row :author do |post|
          link_to post.admin.email, admin_admin_user_path(post.admin)
        end
        row :slug
        row :created_at
      end
    end
  end

  form :html => {:enctype => "multipart/form-data" } do |f|
    f.semantic_errors :base
    f.inputs "Post Details", :multipart => true do
      f.input :title
      f.input :description, as: :html_editor
      f.input :tag_list, :hint => 'Comma separated'
      f.input :categories, as: :check_boxes
      f.inputs :for => :upload_file, name: :upload_file do |file|
        file.input :img_name, :as => :file, :label => 'Image', :hint => file.template.image_tag(file.object.img_name.url, :width => 70, :height => 70)
        file.input :remote_img_name_url, :as => :url
      end
    end
    f.actions
  end

  controller do
    defaults :finder => :find_by_slug

    def create
      @post = current_admin_user.posts.build(post_params)
      if @post.save
        redirect_to admin_post_url(@post), notice: 'Post was successfully created.'
      else
        render :new
      end
    end

    def new
      @post = Post.new
      @post.upload_file = UploadFile.new
    end

    def update
      @post = Post.find_by_slug(params[:id])
      if @post.update(post_params)
        redirect_to admin_post_url(@post), notice: 'Post was successfully updated.'
      else
        render :edit, notice: 'Error has occurred while updating.'
      end
    end

    private
    def post_params
      params.require(:post).permit(:title, :description, :tag_list, :category_ids => [], upload_file_attributes: [:img_name, :remote_img_name_url, :id])
    end
  end

end
