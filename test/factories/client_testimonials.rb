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

