# == Schema Information
#
# Table name: team_photos
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_photo do
    title 'My Team photo'
  end
end
