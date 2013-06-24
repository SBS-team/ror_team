# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |p|
    p.sequence(:email) { |n| "user#{n}@example.com" }
    p.password 'password'
    p.password_confirmation { password }
  end

end