ActiveAdmin.register AdminUser do

  filter :role

  index do
    column :email
    column :role
    column :last_sign_in_at
    default_actions
  end



  form do |f|
    f.inputs "Admin Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role ,:as => :select, :collection =>{'Admin'=>:admin,'Manager'=>:manager,'Team lead'=>:team_lead,'Team'=>:team } ,:selected=>f.object.role,:include_blank=>false
      f.input :about ,:as=>:text
      f.has_many :upload_files do |file|
        file.input :filename,:class=>'test', :as => :file, :label => 'Image', :hint => file.template.image_tag(file.object.filename.url())
        file.input :id, :as => :hidden
      end
    end
    f.actions
  end

  controller do
    def create
      begin
        @admin = AdminUser.new(admin_user_params)
        @admin.save!
        redirect_to admin_admin_user_path(@admin), notice: 'Admin was successfully created.'
      rescue Exception => e
        logger.error(e.message)
        render 'new'
      end
    end
    def edit
      @admin =   AdminUser.find(params[:id])
    end
    def update
      @admin = AdminUser.find(params[:id])
      if @admin.update(admin_user_params)
        redirect_to admin_admin_user_path(@admin), notice: 'Admin was successfully updated.'
      else
        render 'edit'
      end
    end

    private
    def admin_user_params
      params.require(:admin_user).permit(:first_name, :last_name, :email,:role,:about,:password, :password_confirmation,:last_sign_in_at, upload_files_attributes: [:filename, :id])
    end
  end
end
