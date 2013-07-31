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
#

class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  belongs_to :commentable, :polymorphic => true

  validate :check_comment_body

  def check_comment_body
    if (self.description.blank? || self.description.length <= 2)
      errors.add(:Comment, 'is to short, minimum 2 symbols')
    end
  end

end
