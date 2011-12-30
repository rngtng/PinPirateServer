class Game < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :score_events

  belongs_to :player

  scope :latest, lambda { |*slot|
    slot = [1,2,3,4] if slot.empty?
    where(:slot => slot).order("updated_at DESC").limit(1)
  }

end
