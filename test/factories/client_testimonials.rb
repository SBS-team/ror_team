# == Schema Information
#
# Table name: client_testimonials
#
#  id              :integer          not null, primary key
#  comment_text    :text
#  author_name     :string(255)
#  author_position :string(255)
#  project_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client_testimonial do
    sequence :comment_text do |n|
      "nice_comment_#{n}"
    end
    author_name 'Foo Bar'
    project_id 1
  end
end

