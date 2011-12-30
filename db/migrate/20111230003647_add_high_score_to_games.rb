class AddHighScoreToGames < ActiveRecord::Migration
  def change
    add_column :games, :high_score, :integer, :default => 0
  end
end
