ActiveAdmin.register Comment do

  menu :parent => 'Blog'

  filter :description, :as => :string

  index do
    selectable_column
    column :id
    column :description
    column "Email" do |comment|
      comment.commentable.email
    end
    column "Post" do |comment|
      comment.post.title
    end
    default_actions
  end

  form do |f|
    f.inputs 'Comments' do
      f.input :post
      f.input :description
    end
    f.actions
  end

  controller do
    def create
      @comment = current_admin_user.comments.build(comment_params)

      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
      else
        flash[:alert] = 'Comment create error.'
      end
      redirect_to admin_comments_path
    end
    def update
      @comment = Comment.find(params[:id])
      if @comment.update(comment_params)
        redirect_to admin_comment_url(@comment), notice: 'Comment was successfully updated.'
      else
        render :edit, notice: 'Error has occurred while updating.'
      end
    end
    private
    def comment_params
      params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type)
    end
  end
end