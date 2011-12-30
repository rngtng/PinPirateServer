class AddTwitterStatusToGame < ActiveRecord::Migration
  def change
    add_column :games, :twittered_at, :datetime
    rename_column :games, :high_score, :score
  end
end
