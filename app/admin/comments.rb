ActiveAdmin.register Comment do

  index do
    column :id
    column :description
    column "Email" do |comment|
      comment.commentable.email
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

    private
    def comment_params
      params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type)
    end
  end
end