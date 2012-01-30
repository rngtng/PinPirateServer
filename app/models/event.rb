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

