# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do  |p|
    p.first_name 'first_name'
    p.last_name 'last_name'
    p.sequence(:email) { |i| "user_#{i}@mail.com" }
    p.password 'password'
    p.password_confirmation { password }
    p.role 'team'
    p.about 'aboutaboutabout'
    p.sequence(:upload_files) { |i| "#{i}.jpeg" }
  end
end