require 'spec_helper'

describe ScoreEvent do

  let(:player) { Player.create( :name => "Player 1" ) }
  let(:game) { player.games.create }
  let(:score_event) { game.score_events.create :raw_data => ["12", "34", "24"] }

  it "create score" do
    score_event.score.should == 3424
  end

  it "updates game" do
    expect do
      score_event
    end.to change { game.reload.high_score }.to(3424)
  end

end
