class LiveChat < ActiveRecord::Base
  belongs_to :admin_user
  has_many :chat_messages

  validates :guest_name,
            presence: true,
            length: { in: 2..150 }
  validates :guest_email,
            presence: true,
            length: { in: 5..150 }
  validates :admin_id,
            presence: true,
            numericality: { only_integer: true,
                            greater_than: 0 }

end
