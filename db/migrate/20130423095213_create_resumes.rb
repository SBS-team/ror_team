class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.text :decription
      t.integer :job_id
      t.integer :user_id

      t.timestamps
    end
  end
end
