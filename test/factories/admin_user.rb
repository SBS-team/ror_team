# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do  |p|
    p.sequence(:email) { |i| "user_#{i}@mail.com" }
    p.password 'password'
    p.password_confirmation { password }
  end
end