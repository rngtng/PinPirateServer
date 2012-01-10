class Event < ActiveRecord::Base
  belongs_to :game

  validates :data, :presence => true
  validates :game_id, :presence => true

  before_validation :assign_game

  private
  def assign_game
    if self.game.nil?
      self.game = Game.latest.first
    end
  end

end