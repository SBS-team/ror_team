# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  description    :text
#  admin_id       :integer
#  comments_count :integer          default(0)
#  created_at     :datetime
#  updated_at     :datetime
#  slug           :string(255)
#

class Post < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  acts_as_taggable

  belongs_to :admin_user
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :comments, dependent: :destroy
  has_one :upload_file, as: :fileable, dependent: :destroy

  accepts_nested_attributes_for :upload_file

  default_scope {order('posts.created_at DESC')}

  validates :title, presence: true, length: {minimum: 3, maximum: 255}
  validates :description, presence: true, length: {minimum: 10}
  validates :admin_user_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validate  :validates_img_name

  def self.search_posts_based_on_like(search)
    if search
      where('LOWER(title) LIKE LOWER(:word) OR LOWER(description) LIKE LOWER(:word)', word:  "%#{search}%")
    else
      all
    end
  end

  def validates_img_name
    if upload_file.img_name.blank?
      errors.add(:base, "img_name can't be blank")
    end
  end

end
