class ChangeAdminStatusToBool < ActiveRecord::Migration
  def change
    add_column :admin_users, :busy, :boolean, default: false
    remove_column :admin_users, :status
  end
end
