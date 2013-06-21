FactoryGirl.define do
  factory :comment do  |com|
    com.description 'This is my comment ?!'
  end
end
#t.text     "description"
#t.integer  "post_id"
#t.integer  "commentable_id"
#t.string   "commentable_type"