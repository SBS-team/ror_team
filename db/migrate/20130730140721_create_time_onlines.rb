class CreateTimeOnlines < ActiveRecord::Migration
  def change
    create_table :time_onlines do |t|
      t.integer :admin_id
      t.date :day
      t.time :time
    end
  end
end
