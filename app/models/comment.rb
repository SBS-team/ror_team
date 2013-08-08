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

  validates :description,
            :presence => true,
            :length => { :minimum => 2, :maximum => 2048 }

  validates :nickname,
            :presence => true,
            :length => { :minimum => 2, :maximum => 40 }

end
