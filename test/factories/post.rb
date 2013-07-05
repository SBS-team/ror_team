FactoryGirl.define do
  factory :post do
    title 'my post'
    description 'Text for post -> my post'
    association :admin_user, :factory => :admin_user
  end
end