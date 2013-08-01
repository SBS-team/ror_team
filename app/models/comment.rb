# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  description      :text
#  post_id          :integer
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  nickname         :string(255)
#

class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  belongs_to :commentable, :polymorphic => true

  validate :check_comment_body
  validate :check_nickname

  def check_nickname
    if (self.nickname.blank? || self.nickname.length <= 2)
      errors.add(:name, 'Your name is to short, minimum 2 symbols')
    end
  end

  def check_comment_body
    if (self.description.blank? || self.description.length <= 2)
      errors.add(:comment, 'Your comment is to short, minimum 2 symbols')
    end
  end

end
