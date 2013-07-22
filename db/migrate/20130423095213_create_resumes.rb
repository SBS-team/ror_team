class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.text :description
      t.integer :job_id
      t.string :name
      t.string :email
      t.string :phone
      t.timestamps
    end
  end
end