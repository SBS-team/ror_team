class AddTillToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :till, :date
    add_column :projects, :url, :string
  end
end
