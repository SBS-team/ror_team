# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload_file do
    sequence :filename do |n|
      "Filename_#{n}"
    end
  end
end
