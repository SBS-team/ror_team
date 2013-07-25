class CreateLiveChats < ActiveRecord::Migration
  def change
    create_table :live_chats do |t|
      t.string :guest_name, limit: 255
      t.string :guest_email, limit: 255
      t.integer :admin_id

      t.timestamps
    end
  end
end
