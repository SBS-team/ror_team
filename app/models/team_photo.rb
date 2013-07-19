class TeamPhoto < ActiveRecord::Base
  has_many :upload_files, :as => :fileable, dependent: :destroy
  accepts_nested_attributes_for :upload_files

  validates :title,
            :presence => true,
            :uniqueness => true,
            :length => { :in => 5..100 }
  validates :upload_files,
            :presence => true

end
