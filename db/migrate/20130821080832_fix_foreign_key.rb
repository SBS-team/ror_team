class FixForeignKey < ActiveRecord::Migration
  def change
    rename_column :time_onlines, :admin_id, :admin_user_id
    rename_column :posts, :admin_id, :admin_user_id
    rename_column :live_chats, :admin_id, :admin_user_id
  end
end
