class Game < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :score_events

  belongs_to :player

  def high_score
    1111
  end

end
