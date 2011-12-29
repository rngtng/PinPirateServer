require 'spec_helper'

describe EventsController do

  let(:game) { Game.create }

  it "creates event" do
    expect do
      post :create, :game_id => game.id, :event => { :raw_data => "..." }
    end.to change { game.events.count }.by(1)
  end

  it "creates score event" do
    expect do
      post :create, :game_id => game.id, :type => "ScoreEvent", :event => { :raw_data => "..." }
    end.to change { game.score_events.count }.by(1)
  end

  it "returns json" do
    post :create, :game_id => game.id, :type => "ScoreEvent", :event => { :raw_data => "..." }
    response.body.should == game.to_json
  end

  it "fails on no exitsting event" do
    post :create, :game_id => "unkown", :type => "ScoreEvent", :event => { :raw_data => "..." }
    response.status.should == 404
  end
end
