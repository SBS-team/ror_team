class RemoveFioAdminUser < ActiveRecord::Migration
  def change
    remove_column :admin_users, :fio
  end
end
