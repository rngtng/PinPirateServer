class ScoreEvent < Event

  after_create :update_game

  def score
    raw_data[1..-1].map do |val|
      (val.size == 1) ? "0#{val}" : val
    end.join.to_i
  end

  private
  def update_game
    game.update_attributes(:high_score => self.score)
  end
end