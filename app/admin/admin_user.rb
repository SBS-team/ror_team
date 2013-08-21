ActiveAdmin.register AdminUser do

  filter :role, as: :select, collection: ['manager', 'admin', 'team', 'team_lead']

  index do
    selectable_column
    column :image do |admin_user|
      unless admin_user.upload_file.blank?
        image_tag(admin_user.upload_file.img_name.url(:thumb), height: 30)
      end
    end
    column :role
    column :first_name
    column :last_name
    column :email
    column :last_sign_in_at
    default_actions
  end

  show do |admin_user|
    panel 'AdminUser Details' do
      attributes_table_for admin_user do
        row :role
        row :image do
          unless admin_user.upload_file.blank?
            image_tag(admin_user.upload_file.img_name.url(:thumb))
          end
        end
        row :first_name
        row :last_name
        row :email
        row :about
        row :sign_in_count
        row :current_sign_in_at
        row :current_sign_in_ip
        row :last_sign_in_at
        row :last_sign_in_ip
        row :created_at
        row :updated_at
      end
    end
    unless admin_user.time_onlines.blank?
      panel 'Time online' do
        paginated_collection(admin_user.time_onlines.order('day DESC').page(params[:week_page]).per(7),
                             param_name: 'week_page') do
          table_for(collection) do |t|
            t.column 'Day' do |timer|
              timer.day.strftime('%a %d/%m/%Y')
            end
            t.column 'Time online' do |timer|
              hh, mm = timer.time.to_i.divmod(60)
              "#{hh.to_s + ' h' if hh > 0} #{mm.to_s} min"
            end
          end
        end
      end
    end
  end

  form do |f|
    f.inputs 'Admin Details' do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :select, collection: {'Admin' => :admin, 'Manager' => :manager, 'Team lead' => :team_lead,
                                               'Team' => :team}, selected: f.object.role, include_blank: false
      f.input :about, as: :text
      f.inputs for: [:upload_file, f.object.upload_file || UploadFile.new] do |file|
        file.input :img_name, as: :file,
                   hint: file.object.img_name.nil? ? file.template.content_tag(:span, "no map yet") : file.template.image_tag(file.object.img_name.url(:thumb))
        file.input :remote_img_name_url, as: :url
      end
    end
    f.actions
  end

  controller do
    def scoped_collection
      AdminUser.includes([:upload_file]).page(params[:page]).per(30)
    end

    def create
      @admin_user = AdminUser.create(admin_user_params)
      if @admin_user.save
        redirect_to admin_admin_user_path(@admin_user), notice: 'Admin was successfully created.'
      else
       render :new
      end
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
      params.require(:admin_user).permit(:first_name, :last_name, :email, :role, :about,:password,
                                         :password_confirmation, :last_sign_in_at,
                                         upload_file_attributes: [:img_name, :id])
    end
  end

end