class CreateJobsTechnologies < ActiveRecord::Migration
  def change
    create_table :jobs_technologies do |t|
      t.integer :job_id
      t.integer :technology_id
      t.timestamps
    end
  end
end
