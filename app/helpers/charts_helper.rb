module ChartsHelper

  def games_chart
    query = <<-SQL
      SELECT players.`name`, MAX(score) best, SUM(score) total, COUNT(*) cnt
      FROM games
      JOIN players ON player_id = players.id
      GROUP BY player_id
      ORDER BY best DESC
    SQL
    Game.connection.select_all(query)
  end
end
