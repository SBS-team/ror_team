FactoryGirl.define do
  factory :post do  |p|
    p.title 'my post'
    p.description 'Text for post -> my post'
    p.admin_id 2
  end
end