FactoryGirl.define do
  factory :admin_user do  |p|
    p.sequence(:email) { |i| "user_#{i}@mail.com" }
    p.password '123456'
  end
end