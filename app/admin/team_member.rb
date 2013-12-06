ActiveAdmin.register TeamMember do

  permit_params :name, :last_name, :team_role_id

  menu parent: 'Team', priority: 0

  filter :name, as: :string

end