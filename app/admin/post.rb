ActiveAdmin.register Post do

  menu :parent => 'Blog',  :priority => 0

  filter :categories, :as => :select, :collection => Category.all
  filter :title, :as => :string
  filter :description, :as => :string

  index do
    selectable_column
    column :image do |post|
      unless post.upload_file.blank?
        image_tag(post.upload_file.img_name.url, height: 30)
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
      link_to post.admin_user.email, admin_admin_user_path(post.admin_user)
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
          link_to post.admin_user.email, admin_admin_user_path(post.admin_user)
        end
        row :slug
        row :created_at
      end
    end
  end

  form :html => {:enctype => 'multipart/form-data' } do |f|
    f.semantic_errors :base
    f.inputs 'Post Details', :multipart => true do
      f.input :title
      f.input :description, :as => :text, input_html: {class: 'ckeditor'}
      f.input :tag_list, :hint => 'Comma separated'
      f.input :categories, as: :check_boxes
      f.inputs :for => [:upload_file, f.object.upload_file || UploadFile.new] do |file|
        file.input :img_name, :as => :file, :hint => file.object.img_name.nil? ? file.template.content_tag(:span, 'no map yet') : file.template.image_tag(file.object.img_name.url(:thumb))
        file.input :remote_img_name_url, :as => :url
        file.input :id, :as => :hidden
      end
    end
    f.actions
  end

  controller do
    defaults :finder => :find_by_slug

    def scoped_collection
      unless params[:tag_name].blank?
        Post.joins(:tags).includes([:categories, :upload_file, :admin_user]).where("tags.name = :tag_name", :tag_name=>params[:tag_name]).page(params[:page]).per(30)
      else
        Post.includes([:tags, :categories, :upload_file, :admin_user]).page(params[:page]).per(30)
      end
    end

    def create
      @post = current_admin_user.posts.build(post_params)
      if @post.save
        redirect_to admin_post_url(@post), notice: 'Post was successfully created.'
      else
        render :new, notice: 'Error has occurred while creating.'
      end
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
