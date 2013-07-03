# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  since       :date
#  team_size   :integer
#  created_at  :datetime
#  updated_at  :datetime
#  till        :date
#  url         :string(255)
#

class Project < ActiveRecord::Base
  has_many :project_services, dependent: :destroy
  has_many :services, through: :project_services

  has_many :project_technology_categories, dependent: :destroy
  has_many :technologies, through: :project_technology_categories
  has_many :upload_files, :as => :fileable
  accepts_nested_attributes_for :upload_files
  accepts_nested_attributes_for :project_technology_categories, allow_destroy: true

  #attr_accessible :name, :description, :since, :team_size

  validates :name,
            :presence => true,
            :uniqueness => true,
            :length => { :minimum => 3,
                         :maximum => 45 }
  validates :description,
            :presence => true,
            :length => { :in => 10..500 }
  validates :since,
            :presence => true
  validates :team_size,
            :presence => true,
            :numericality => {  :only_integer => true,
                                :greater_than => 0 }

end

