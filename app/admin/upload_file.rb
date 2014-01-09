ActiveAdmin.register UploadFile do

  scope :all
  filter :fileable_type
  filter :filename

  index do
    selectable_column
    column :image do |upload_file|
      image_tag(upload_file.img_name.url, width: 50, height: 50 )
    end
    column 'image name' do |upload_file|
      upload_file.img_name.to_s.rpartition('/')[2]
    end
    column :fileable_type
    column :link do |upload_file|
      file = upload_file.fileable
      title = if file.respond_to?(:title)
                file.title
              elsif file.respond_to?(:first_name)
                file.first_name + ' ' + file.last_name
              elsif file.respond_to?(:name)
                file.name
              else
                file.description
              end
      link_to title, [:admin, file]
    end
  end

  form html: {enctype: 'multipart/form-data'} do |f|
    f.semantic_errors :base
    f.inputs 'Upload file', multipart: true do
      f.input :img_name, as: :file, label: 'Image', hint: f.template.image_tag(f.object.filename.url, width: 70, height: 70)
      f.input :remote_img_name_url, as: :url
      f.input :fileable_type, as: :hidden
    end
    f.actions
  end

  controller do

    def create
      @upload_file = UploadFile.new(file_params)
      if @upload_file.save
        redirect_to admin_upload_file_url(@post), notice: 'Post was successfully created.'
      else
        render :new
      end
    end

    def new
      @upload_file = UploadFile.new(fileable_type: 'UploadFile')
    end

    private
    def file_params
      params.require(:upload_file).permit(:fileable_type, :remote_img_name_url, :img_name, :filename, :id)
    end
  end

end