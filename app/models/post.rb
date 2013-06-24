# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  admin_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Post < ActiveRecord::Base

  acts_as_taggable
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :admin, :class_name => "AdminUser", :foreign_key => "admin_id"

  validates :title,
            :presence => true,
            :length => { :minimum => 3, :maximum => 255 }
  validates :description,
            :presence => true,
            :length => { :minimum => 10}
  validates :admin_id,
            :presence => true,
            :numericality => { :only_integer => true, :greater_than => 0 }
end
