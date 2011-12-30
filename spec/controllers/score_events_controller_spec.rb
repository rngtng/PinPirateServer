require 'spec_helper'

describe ScoreEventsController do

  let(:game) { Game.create }
  let(:raw_data) { ["12", "2", "30"] }

  it "creates score event" do
    expect do
      post :create, :game_id => game.id, :event => { :raw_data => raw_data }
    end.to change { game.score_events.count }.by(1)
  end

  it "returns json" do
    post :create, :game_id => game.id, :event => { :raw_data => raw_data }
    response.body.should == assigns(:event).to_json(:only => [:id, :game_id], :methods => [:score])
  end

end
