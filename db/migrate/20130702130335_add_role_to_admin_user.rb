class AddRoleToAdminUser < ActiveRecord::Migration
  def change
    add_column  :admin_users, :role, :string
    add_column  :admin_users, :screen_name, :string
  end
end
