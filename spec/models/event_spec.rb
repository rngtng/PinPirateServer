require 'spec_helper'

describe Event do

  let(:game) { create(:game) }
  let(:event) { game.events.create! :data => data }
  let(:data) { ["0c", "34", "24"].join }

  it "stores data as array" do
    event.reload.data.should == data
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

