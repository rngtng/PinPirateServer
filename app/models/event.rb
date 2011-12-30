class Event < ActiveRecord::Base
  belongs_to :game

  validates :raw_data, :presence => true
  validates :game_id, :presence => true

  serialize :raw_data
end
