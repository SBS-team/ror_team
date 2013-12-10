class TeamRole < ActiveRecord::Base

  has_many :team_members

  validates :name, presence: true, uniqueness: true, length: {in: 1..50}

end