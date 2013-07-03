FactoryGirl.define do
  factory :comment do
    sequence :description do |n|
      "comment_#{n}"
    end

  end
end
#t.integer  "post_id"
#t.integer  "commentable_id"
#t.string   "commentable_type"