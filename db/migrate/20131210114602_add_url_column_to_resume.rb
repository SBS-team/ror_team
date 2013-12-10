class AddUrlColumnToResume < ActiveRecord::Migration
  def change
    remove_column :resumes, :phone
    add_column :resumes, :git_url, :string
  end
end
