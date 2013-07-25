class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.string :body
      t.integer :live_chat_id
      t.boolean :is_admin
      t.datetime :created_at
    end
  end
end
