ActiveAdmin.register User do

  menu :priority => 1

  filter :email, :as => :string
  filter :first_name, :as => :string
  filter :last_name, :as => :string
  filter :ban, :as => :check_boxes

  batch_action 'Ban', :priority => 1, :confirm => 'Are you sure you want to ban all selected users?' do |selection|
    User.find(selection).each do |user|
      user.update_attribute(:ban, true)
    end
    redirect_to admin_users_path, :notice => 'All selected users banned !!!'
  end
  batch_action 'Unban', :confirm => 'Are you sure you want to unban all selected users?' do |selection|
    User.find(selection).each do |user|
      user.update_attribute(:ban, false)
    end
    redirect_to admin_users_path, :notice => 'All selected users unbanned !!!'
  end

  index do
    selectable_column
    column :email
    column :first_name
    column :last_name
    column :phone
    column :skype
    column 'Ban?' do |user|
      status_tag (user.ban ? 'Ban' :'Free'), (user.ban ? :error : :ok)
    end
    default_actions
  end
  form :html => {:enctype => 'multipart/form-data' } do |f|
    f.semantic_errors :base
    f.inputs "User details", :multipart => true do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :skype
      f.input :ban, :as => :boolean
      f.has_many :upload_files do |file|
        file.input :filename, :as => :file, :label => 'Image'
        file.input :id, :as => :hidden
      end
    end
    f.actions
  end

  controller do
    def create
        @user = User.new(user_params)
       if @user.save
        redirect_to admin_user_url(@user), notice: 'User was successfully created.'
      else
        render :new
      end
    end
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to edit_admin_user_url(@user), notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone, :skype, :ban, upload_files_attributes: [:img_name, :id])
    end
  end
end