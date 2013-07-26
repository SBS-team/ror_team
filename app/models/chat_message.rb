# == Schema Information
#
# Table name: chat_messages
#
#  id           :integer          not null, primary key
#  body         :string(255)
#  live_chat_id :integer
#  is_admin     :boolean
#  created_at   :datetime
#

class ChatMessage < ActiveRecord::Base
  belongs_to :live_chat

  validates :body,
            presence: true
  validates :live_chat_id,
            presence: true,
            numericality: {only_integer: true,
                          greater_than: 0 }
  validates :is_admin,
            inclusion: { in: [true, false]}

  after_create :push_message    ### after_save ???

  def push_message
    true
  end
end
