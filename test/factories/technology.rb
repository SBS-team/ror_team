FactoryGirl.define do
  factory :technology do
    sequence :name do |n|
      "Technology_#{n}"
    end
  end
end
