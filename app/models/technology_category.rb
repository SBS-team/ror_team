# == Schema Information
#
# Table name: technology_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TechnologyCategory < ActiveRecord::Base
  has_many :technologies, dependent: :destroy

  validates :name,
            :presence => true,
            :uniqueness => true,
            :length => { :in => 1..45 }
end
