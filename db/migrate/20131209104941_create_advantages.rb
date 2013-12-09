class CreateAdvantages < ActiveRecord::Migration
  def change
    create_table :advantages do |t|
      t.text :description
      t.timestamps
    end
  end
end
