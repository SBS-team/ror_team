# == Schema Information
#
# Table name: post_categories
#
#  id          :integer          not null, primary key
#  post_id     :integer
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class PostCategory < ActiveRecord::Base

  belongs_to :post
  belongs_to :category
  #validates :post_id, :uniqueness => { :scope => :category_id }
end
