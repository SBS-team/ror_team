# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload_file do |f|
    f.filename { Rack::Test::UploadedFile.new(File.join(Rails.root, 'test', 'factories', 'files', '1.jpg')) }
  end
end
