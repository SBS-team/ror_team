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
  belongs_to :commentable, :polymorphic => true
  belongs_to :post, :counter_cache => true

  validates :description,
            :presence => true,
            :length => { :minimum => 5}
  validates :commentable_id,
            :presence => true,
            :numericality => { :only_integer => true, :greater_than => 0 }
  validates :commentable_type,
            :presence => true,
            :length => { :maximum => 255 }
end
