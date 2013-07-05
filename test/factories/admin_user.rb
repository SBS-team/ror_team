# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do  |p|
    p.sequence(:email) { |i| "user_#{i}@mail.com" }
    p.password 'password'
    p.password_confirmation { password }
    p.role 'admin'
    p.fio 'admin'
    p.about 'I am admin'
  end
end