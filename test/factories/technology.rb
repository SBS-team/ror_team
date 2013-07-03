FactoryGirl.define do
  factory :technology do
    sequence :name do |n|
      "Technology_#{n}"
    end
    technology_category_id 1
  end
end
