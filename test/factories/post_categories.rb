# == Schema Information
#
# Table name: post_categories
#
#  id          :integer          not null, primary key
#  post_id     :integer
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post_category do
    post_id 1
    category_id 1
  end
end
