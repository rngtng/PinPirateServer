class AddSlotToGames < ActiveRecord::Migration
  def change
    add_column :games, :slot, :integer, :default => 1
  end
end
