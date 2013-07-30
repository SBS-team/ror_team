# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chat_message do
    body 'very big and important message'
    is_admin false
    live_chat_id 1
  end
end
