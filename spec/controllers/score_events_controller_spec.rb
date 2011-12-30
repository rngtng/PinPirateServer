require 'spec_helper'

describe ScoreEventsController do

  it "creates score event" do
    expect do
      post :create, :game_id => game.id, :event => { :raw_data => "..." }
    end.to change { game.score_events.count }.by(1)
  end

  it "returns json" do
    post :create, :game_id => game.id, :event => { :raw_data => "..." }
    response.body.should == assigns(:event).to_json(:only => [:id, :game_id], :methods => [:score])
  end

  it "fails on no exitsting event" do
    post :create, :game_id => "unkown", :event => { :raw_data => "..." }
    response.status.should == 404
  end

end
