class AddTimerAtToGames < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.datetime :timer_at
    end
  end
end
