class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :player

      t.timestamps
    end
    add_index :games, :player_id
  end
end
