FactoryGirl.define do
  factory :comment do
    sequence :description do |n|
      "comment_#{n}"
    end

    nickname 'user'
    post_id 2
  end
end
#t.integer  "post_id"
#t.integer  "commentable_id"
#t.string   "commentable_type"