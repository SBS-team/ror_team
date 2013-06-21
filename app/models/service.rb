class Service < ActiveRecord::Base
  has_many :project_services, dependent: :destroy
  has_many :projects, through: :project_services

  validates :name,
            :presence => true,
            :uniqueness => true,
            :length => { :in => 5..45 }
end
