# == Schema Information
#
# Table name: live_chats
#
#  id          :integer          not null, primary key
#  guest_name  :string(255)
#  guest_email :string(255)
#  admin_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class LiveChat < ActiveRecord::Base
  belongs_to :admin_user,
             foreign_key: 'admin_id'
  has_many :chat_messages

  validates :guest_name,
            presence: true,
            length: { in: 2..150 }
  #validates :guest_email,
  #          presence: true,
  #          length: { in: 5..150 }
  validates :admin_id,
            presence: true,
            numericality: { only_integer: true,
                            greater_than: 0 }

end
