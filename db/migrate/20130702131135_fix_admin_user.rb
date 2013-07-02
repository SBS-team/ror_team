class FixAdminUser < ActiveRecord::Migration
  def change
    add_column  :admin_users, :about, :text
    remove_column  :admin_users, :screen_name, :string
  end
end
