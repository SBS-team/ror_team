class AddFielsToAuthentication < ActiveRecord::Migration
  def change
    add_column  :authentications, :name, :string
    add_column  :authentications, :screen_name, :string
  end
end
