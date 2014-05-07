# == Schema Information
#
# Table name: team_members
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  last_name    :string(255)
#  team_role_id :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_member do
    name "MyString"
    last_name "MyString"
  end
end
