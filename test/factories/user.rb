# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |p|
    p.sequence(:email) { |n| "social#{n}@example.com" }
    p.password Devise.friendly_token[0,20]
    p.password_confirmation { password }
    p.image 'http://a0.twimg.com/profile_images/3061527294/fe1fa92c0188e82ed27cff13bde19b89_normal.jpeg'
  end

end