class DeleteFileFromResume < ActiveRecord::Migration
  def change
    remove_column  :resumes, :file
  end
end
