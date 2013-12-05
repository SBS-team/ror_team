ActiveAdmin.register ActsAsTaggableOn::Tag, as:'Tags' do

  menu parent: 'News', priority: 0

  filter :name, as: :string

end