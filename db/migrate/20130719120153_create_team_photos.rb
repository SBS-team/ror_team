class CreateTeamPhotos < ActiveRecord::Migration
  def change
    create_table :team_photos do |t|
      t.string :title
      t.timestamps
    end
  end
end