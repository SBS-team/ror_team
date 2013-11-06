class CreateJobTechnologies < ActiveRecord::Migration
  def change
    create_table :job_technologies do |t|
      t.integer :job_id
      t.integer :technology_id
      t.timestamps
    end
  end
end
