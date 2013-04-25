class Post < ActiveRecord::Base

  acts_as_taggable

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :admin, :class_name => "AdminUser", :foreign_key => "admin_id"
end