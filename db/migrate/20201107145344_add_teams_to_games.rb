class AddTeamsToGames < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.integer :teams
    end
  end
end
