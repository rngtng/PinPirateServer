# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    player
  end
end

# == Schema Information
#
# Table name: games
#
#  id           :integer(4)      not null, primary key
#  player_id    :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  score        :integer(4)      default(0)
#  slot         :integer(4)      default(1)
#  twittered_at :datetime
#  finished_at  :datetime
#
# Indexes
#
#  index_games_on_player_id  (player_id)
#

