class FioAddToAdminUser < ActiveRecord::Migration
  def change
    add_column  :admin_users, :fio, :string
  end
end
