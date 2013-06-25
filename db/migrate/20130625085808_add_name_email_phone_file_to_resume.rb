class AddNameEmailPhoneFileToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :name, :string
    add_column :resumes, :email, :string
    add_column :resumes, :phone, :string
    add_column :resumes, :file, :string
  end
end
