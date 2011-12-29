class Event < ActiveRecord::Base
  belongs_to :game

  validates :raw_data, :presence => true

end
