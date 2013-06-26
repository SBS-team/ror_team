# == Schema Information
#
# Table name: technologies
#
#  id                             :integer          not null, primary key
#  name                           :string(255)
#  technology_category_id         :integer
#  project_technology_category_id :integer
#  created_at                     :datetime
#  updated_at                     :datetime
#

class Technology < ActiveRecord::Base
  belongs_to :technology_category
  has_many :project_technology_categories, dependent: :destroy
  has_many :projects, through: :project_technology_categories

  validates :name,
            :presence => true,
            :uniqueness => true,
            :length => { :in => 1..45 }

  validates :technology_category_id,
            :presence => true,
            :numericality => {  :only_integer => true,
                                :greater_then => 0 }
end
