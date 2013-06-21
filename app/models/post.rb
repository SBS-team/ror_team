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

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :admin, :class_name => "AdminUser", :foreign_key => "admin_id"

  validates :title, :description, presence: true
end
