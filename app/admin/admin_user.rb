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
      f.input :about ,:as => :text
      f.has_many :upload_files do |file|
        if params[:upload_files_attributes].blank?
          file.input :img_name, :class=> 'test', :as => :file, :label => 'Image'
        else
          file.template.image_tag(file.object.img_name.url, :width => 200, :height => 200)
        end
          file.input :id, :as => :hidden
      end
      # Политика безопасности рельсов не дает увидеть ранее загруженный файл после повторного рендера формы
      # Так что я не знаю как зделать что бы при едите чего либо подружалась ранее загруженная пикча((
    end
    f.actions
  end

  controller do
    def create
      @admin_user = AdminUser.create(admin_user_params)
      if @admin_user.save
        redirect_to admin_admin_user_path(@admin_user), notice: 'Admin was successfully created.'
      else
       render :new
      end
    end

    def edit
      @admin_user = AdminUser.find(params[:id])
    end
    def update
      @admin_user = AdminUser.find(params[:id])
      if @admin_user.update(admin_user_params)
        redirect_to admin_admin_user_path(@admin_user), notice: 'Admin was successfully updated.'
      else
        render :edit
      end
    end

    private
    def admin_user_params
      params.require(:admin_user).permit(:first_name, :last_name, :email,:role,:about,:password, :password_confirmation,:last_sign_in_at, upload_files_attributes: [:img_name, :id])
    end
  end
  end
