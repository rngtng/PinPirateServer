require "tweet"

class Game < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :score_events

  belongs_to :player

  # validates :slot, :presence => true

  scope :not_finished, where("finished_at IS NULL")
  scope :finished, where("finished_at IS NOT NULL")
  scope :not_tweeted, where("twittered_at IS NULL")

  scope :with_slot, lambda { |*slot|
    slot = [1,2,3,4] if slot.empty?
    where(:slot => slot)
  }

  scope :running, lambda { |*slot|
    with_slot(*slot).not_finished
  }

  scope :latest, order("updated_at DESC").limit(1)

  scope :current, lambda { |*slot|
    running(*slot).latest
  }

  def self.get_slot(slot)
    slot.to_i(16) - 11
  end

  def duration
    (updated_at - created_at).round
  end

  def score_s
    "%08d" % score
  end

  def finish!
    self.update_attribute(:finished_at, Time.now) if self.finished_at.nil?
  end

  def tweet!
    if( self.twittered_at.nil? )

      text = if high_score?
        "Kawabonga!!!! #{player.handle} just shoot a new HighScore:  #{score}"
      else
        "Turtleicious! #{player.handle} just scored: #{score}"
      end

      Tweet.do(text)
      self.update_attribute(:twittered_at, Time.now)
    end
  end

  def high_score?
    (Game.where("score > #{score}").count == 0)
  end

end
