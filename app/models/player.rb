class Player < ActiveRecord::Base
  has_many :games

  before_validation :check_twitter_handle

  validates :name, :presence => true, :uniqueness => true

  def self.find_or_build_by(attrs)
    where(attrs).first || new(attrs)
  end

  def handle
    twitter_handle.present? ? twitter_handle : name
  end

  private
  def check_twitter_handle
    if twitter_handle.present? && !twitter_handle.include?('@')
      self.twitter_handle = "@#{twitter_handle}"
    end
  end
end
