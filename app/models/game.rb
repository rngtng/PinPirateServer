class Game < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :score_events

  belongs_to :player

  # validates :slot, :presence => true

  scope :latest, lambda { |*slot|
    slot = [1,2,3,4] if slot.empty?
    where(:slot => slot).order("updated_at DESC").limit(1)
  }

  def self.get_slot(slot)
    mappings = {
      "1"  => 1, "2"  => 2, "3"  => 3, "4"  => 4,
      "C"  => 1, "D"  => 2, "E"  => 3, "F"  => 4,
      "12" => 1, "13" => 2, "14" => 3, "15" => 4,
    }
    mappings[slot.to_s]
  end

  def duration
    (updated_at - created_at).round
  end

  def high_score_s
    "%08d" % high_score
  end
end
