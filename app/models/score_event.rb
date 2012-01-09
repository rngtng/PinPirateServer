class ScoreEvent < Event

  before_validation :check_game_slot, :check_game, :check_game_score
  after_create :update_game

  validate :slot_value

  def slot
    Game.get_slot(data[0...2])
  end

  def score
    data[2..-1].to_i
  end

  private
  def slot_value
    errors.add(:slot, "is wrong") unless (1..4).member?(self.slot)
  end

  def check_game_slot
    if self.game.nil? || self.game.slot != self.slot
      self.game = Game.current(self.slot).first
      #self.game.iball += 1
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
      Game.running.map &:finish!
      self.game = Game.create!(:player => self.game.player, :slot => self.game.slot)
    end
  end

  def update_game
    game.update_attributes(:score => self.score)
  end
end