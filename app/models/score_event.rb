class ScoreEvent < Event

  before_validation :check_if_right_game_slot, :check_game, :check_if_new_game
  after_create :update_game

  validate :slot_value

  def slot
    @slot = Game.get_slot(data_array.first)
  end

  def score
    data[2..-1].to_i
  end

  def data_array
    @data_array = data.scan(/../)
  end

  private
  def slot_value
    errors.add(:slot, "is wrong") unless (1..4).member?(self.slot)
  end

  # switch to next player
  def check_if_right_game_slot
    if self.game.nil? || self.game.slot != self.slot
      self.game = Game.latest.with_slot(self.slot).first
      #self.game.iball += 1
    end
  end

  # case of empty DB
  def check_game
    self.game ||= begin
      #TODO get player from last game
      # TODO write test  where "Player 3" already exits
      player = Player.find_or_create_by(:name => "Player #{self.slot}")
      Game.create!(:player => player, :slot => self.slot)
    end
  end

  # switch to new game
  def check_if_new_game
    if self.game.score > self.score
      Game.not_finished.map &:finish!
      self.game = Game.create!(:player => self.game.player, :slot => self.game.slot)
    end
  end

  def update_game
    game.update_attributes(:score => self.score)
  end
end

# == Schema Information
#
# Table name: events
#
#  id         :integer(4)      not null, primary key
#  game_id    :integer(4)
#  type       :string(255)
#  data       :string(255)     default(""), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_events_on_game_id  (game_id)
#

