class Player < ActiveRecord::Base
  has_many :games

  before_validation :check_twitter_handle

  validates :name, :presence => true, :uniqueness => true

  def self.find_or_create_by(attrs)
    where(attrs).first || create(attrs)
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

# == Schema Information
#
# Table name: players
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  twitter_handle :string(255)
#  rfid_id        :string(255)
#

