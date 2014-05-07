# == Schema Information
#
# Table name: upload_files
#
#  id            :integer          not null, primary key
#  filename      :string(255)
#  img_name      :string(255)
#  fileable_id   :integer
#  fileable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload_file do
    img_name { File.open(File.join(Rails.root, 'test', 'factories', 'files', 'image.png')) }
    filename { File.open(File.join(Rails.root, 'test', 'factories', 'files', '1.doc')) }
  end


end
