class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, limit: 255
      t.text :description
      t.integer :admin_id
      t.integer :comments_count, default: 0
      t.timestamps
    end
  end
end