class ScoreEvent < Event

  before_validation :check_game_slot, :check_game, :check_game_score
  after_create :update_game

  validate :slot_value

  def slot
    Game.get_slot(raw_data.first)
  end

  def score
    raw_data[1..-1].map do |val|
      (val.size == 1) ? "0#{val}" : val
    end.join.to_i
  end

  private
  def slot_value
    errors.add(:slot, "is wrong") unless self.slot
  end

  def check_game_slot
    if self.game.nil? || self.game.slot != self.slot
      self.game = Game.latest(self.slot).first
    end
  end

  def check_game
    self.game ||= begin
      player = Player.create!(:name => "Player #{self.slot}")
      Game.create!(:player => player, :slot => self.slot)
    end
  end

  def check_game_score
    if self.game.score > self.score
      self.game = Game.create!(:player => self.game.player, :slot => self.game.slot)
    end
  end

  def update_game
    game.update_attributes(:score => self.score)
  end
end