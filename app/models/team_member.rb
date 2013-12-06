class TeamMember < ActiveRecord::Base

  belongs_to :team_role

  accepts_nested_attributes_for :team_role

end