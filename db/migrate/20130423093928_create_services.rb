class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, limit: 255
      t.timestamps
    end
  end
end