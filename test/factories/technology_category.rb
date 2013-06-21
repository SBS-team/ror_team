FactoryGirl.define do
  factory :TechnologyCategory do
    sequence :name do |n|
      "Technology_Category_#{n}"
    end
  end
end
