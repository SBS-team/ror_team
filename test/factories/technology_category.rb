FactoryGirl.define do
  factory :technology_category do
    sequence :name do |n|
      "Technology_Category_#{n}"
    end
  end
end
