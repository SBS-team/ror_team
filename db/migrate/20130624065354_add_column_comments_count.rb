class AddColumnCommentsCount < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, :default => 0

    Post.reset_column_information
    Post.find(:all).each do |post|
      post.update_attribute :comments_count, post.comments.length
    end
  end
end
