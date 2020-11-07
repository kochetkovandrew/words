class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :code
      t.integer :x
      t.integer :y
      t.text :words
      t.text :results
    end
  end
end
