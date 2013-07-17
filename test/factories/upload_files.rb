# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload_file do
    img_name { File.open(File.join(Rails.root, 'test', 'factories', 'files', 'image.png')) }
  end


end
