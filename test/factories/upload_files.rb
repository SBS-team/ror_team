# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload_file do
    filename "MyString"
    fileable_id ""
    fileable_type "MyString"
  end
end
