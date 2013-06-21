class TechnologyCategory < ActiveRecord::Base
  has_many :technologies, dependent: :destroy

  validates :name,
            :presence => true,
            :uniqueness => true,
            :length => { :minimum => 3,
                         :maximum => 45 }
end
