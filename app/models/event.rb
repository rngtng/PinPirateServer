class Event < ActiveRecord::Base
  belongs_to :game

  validates :data, :presence => true
  validates :game_id, :presence => true
end