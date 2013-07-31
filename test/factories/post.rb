FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "post#{n} my post"}
    description 'Text for post -> my post'
  end
end