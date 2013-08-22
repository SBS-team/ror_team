class RemoveGuestEmailFromLiveChats < ActiveRecord::Migration
  def change
    remove_column :live_chats, :guest_email, :string
  end
end
