ActiveAdmin.register TeamRole do

  permit_params :name

  menu parent: 'Team'

  filter :name, as: :string

end