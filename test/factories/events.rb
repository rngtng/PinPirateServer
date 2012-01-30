# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    game
  end
end

# == Schema Information
#
# Table name: events
#
#  id         :integer(4)      not null, primary key
#  game_id    :integer(4)
#  type       :string(255)
#  data       :string(255)     default(""), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_events_on_game_id  (game_id)
#

