class DropNotUsedTables < ActiveRecord::Migration
  def change
    drop_table :live_chats
    drop_table :chat_messages
  end
end
