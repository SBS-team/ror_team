FactoryGirl.define do
  factory :service do
    sequence :name do |n|
      "Service_#{n}"
    end
  end
end
