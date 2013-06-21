# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do |p|
    p.sequence(:title) { |n| "Job title #{n}" }
    p.description "Description text"
  end
end