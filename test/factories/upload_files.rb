# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload_file do
    sequence :filename do |n|
      "filename#{n}"
    end
  end


end
