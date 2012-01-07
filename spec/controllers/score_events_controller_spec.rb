require 'spec_helper'

describe ScoreEventsController do

  let!(:game) { create(:game, :score => 200, :slot => 1) }
  let(:data) { ["0c", "02", "30"].join }

  it "creates score event" do
    expect do
      post :create, :game_id => game.id, :event => { :data => data }
    end.to change { game.score_events.count }.by(1)
  end

  it "returns json" do
    post :create, :game_id => game.id, :event => { :data => data }
    response.body.should == assigns(:event).to_json(:only => [:id, :game_id], :methods => [:score])
  end

  context "with lower score" do
    let!(:game) { create(:game, :score => 1000, :slot => 1) }

    it "adds score event to current game" do
      expect do
        post :create, :game_id => game.id, :event => { :data => data }
      end.to change { Game.count }.by(1)
    end
  end

  context "with different slot" do
    let!(:game) { create(:game, :score => 200, :slot => 2) }

    it "adds score event to current game" do
      expect do
        post :create, :game_id => game.id, :event => { :data => data }
      end.to change { Game.count }.by(1)
    end
  end

end
