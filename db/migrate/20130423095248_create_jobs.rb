class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title, limit: 255
      t.text :description

      t.timestamps
    end
  end
end
