class Technology < ActiveRecord::Base
  belongs_to :technology_category
  has_many :project_technology_categories, dependent: :destroy
  has_many :projects, through: :project_technology_categories

  validates :name,
            :presence => true,
            :uniqueness => true,
            :length => { :in => 5..45 }

  validates :technology_category_id,
            :presence => true,
            :numericality => {  :only_integer => true,
                                :greater_then => 0 }
end
