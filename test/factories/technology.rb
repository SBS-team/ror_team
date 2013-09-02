FactoryGirl.define do
  factory :technology do
    sequence :name do |n|
      "Technology_#{n}"
    end
    association :technology_category, factory: :technology_category
  end
end
