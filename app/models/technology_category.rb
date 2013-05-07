class TechnologyCategory < ActiveRecord::Base
  has_many :technologies, dependent: :destroy
end
