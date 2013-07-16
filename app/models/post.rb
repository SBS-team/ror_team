# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  description    :text
#  admin_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#  comments_count :integer          default(0)
#

class Post < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  acts_as_taggable
  has_many :post_categories, :dependent => :destroy
  has_many :categories, through: :post_categories
  has_many :comments, :dependent => :destroy
  belongs_to :admin, :class_name => "AdminUser", :foreign_key => "admin_id"
  has_many :upload_files, :as => :fileable, :dependent => :destroy
  accepts_nested_attributes_for :upload_files
  validates :title,
            :presence => true,
            :length => { :minimum => 3, :maximum => 255 }
  validates :description,
            :presence => true,
            :length => { :minimum => 10}
  validates :admin_id,
            :presence => true,
            :numericality => { :only_integer => true, :greater_than => 0 }
  validates :upload_files,
            :presence => true

  def self.search_posts_based_on_like(search)
    if search
      where('LOWER(title) LIKE LOWER(:word) OR LOWER(description) LIKE LOWER(:word)', :word=>"%#{search}%")
    else
      all
    end
  end

end
