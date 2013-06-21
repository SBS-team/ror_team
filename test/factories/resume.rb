# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resume do |p|
    association :user
    association :job
    p.description "Description text"
  end
end