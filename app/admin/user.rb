ActiveAdmin.register User do
  index do
    column :email
    column :first_name
    column :last_name
    column :phone
    column :skype
    default_actions
  end
  form :html => {:enctype => "multipart/form-data" } do |f|
    f.semantic_errors :base
    f.inputs "User details", :multipart => true do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :skype
      f.has_many :upload_files do |file|
        file.input :filename, :as => :file, :label => 'Image'
        file.input :id, :as => :hidden
      end
    end
    f.buttons
  end

  controller do
    def create
      begin
        @user = User.new(user_params)
        @user.save!
        redirect_to admin_user_url(@user), notice: 'User was successfully created.'
      rescue Exception => e
        logger.error(e.message)
        render 'new'
      end
    end
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to edit_admin_user_url(@user), notice: 'User was successfully updated.'
      else
        render 'edit'
      end
    end
    private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone, :skype, upload_files_attributes: [:filename, :id])
    end
  end
end