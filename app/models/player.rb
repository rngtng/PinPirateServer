class Player < ActiveRecord::Base
  has_many :games

  validates :name, :presence => true, :uniqueness => true

  def self.find_or_build_by(attrs)
    where(attrs).first || new(attrs)
  end
end
