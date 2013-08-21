ActiveAdmin.register ActsAsTaggableOn::Tag, as:'Tags' do

  menu parent: 'Blog', priority: 0

  filter :name, as: :string

end