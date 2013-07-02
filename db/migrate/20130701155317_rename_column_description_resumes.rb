class RenameColumnDescriptionResumes < ActiveRecord::Migration
  def change
    rename_column :resumes, :decription, :description
  end
end
