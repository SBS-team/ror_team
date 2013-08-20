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
  include Humanizer
  require_human_on :create

  attr_accessor :admin

  belongs_to :post, :counter_cache => true
  belongs_to :commentable, :polymorphic => true

  validates :description,
            :presence => true,
            :length => { :minimum => 2, :maximum => 2048 }

  validates :nickname,
            :presence => true,
            :length => { :minimum => 2, :maximum => 40 }

  validates :post_id,
            :presence => true,
            numericality: { only_integer: true,
                            greater_than: 0 }

  validate :validates_nickname


  def validates_nickname
    if self.nickname.downcase[/\Aadmin/]
      if self.admin
        return true
      else
        unless self.nickname.downcase[6..-1].blank?
          return true
        else
          errors.add(:nickname, "You can't use nickname: admin.")
          return false
        end
      end
    end
      return true
  end

end
