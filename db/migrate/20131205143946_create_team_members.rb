class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :last_name
      t.string :team_role_id

      t.timestamps
    end
  end
end