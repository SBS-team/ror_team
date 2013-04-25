class Post < ActiveRecord::Base

  acts_as_taggable

  has_many :comments, as: :commentable, dependent: :destroy
end