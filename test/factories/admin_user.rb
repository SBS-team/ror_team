# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do  |p|
    p.sequence(:first_name) { |j| "first_name#{j}" }
    p.last_name 'last_name'
    p.sequence(:email) { |i| "user_#{i}@mail.com" }
    p.password 'password'
    p.password_confirmation { password }
    p.role 'team'
    p.about 'aboutaboutabout'
    p.upload_files [UploadFile.create(:filename => File.open(Rails.root.join('1.jpg')))]
  end
end