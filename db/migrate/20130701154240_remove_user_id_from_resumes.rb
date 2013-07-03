class RemoveUserIdFromResumes < ActiveRecord::Migration
  def change
    remove_column :resumes, :user_id, :integer
  end
end
