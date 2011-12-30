require 'spec_helper'

describe EventsController do

  let(:game) { Game.create }
  let(:raw_data) { ["A"] }

  it "creates event" do
    expect do
      post :create, :game_id => game.id, :event => { :raw_data => raw_data }
    end.to change { game.events.count }.by(1)
  end

  it "fails on no exitsting event" do
    post :create, :game_id => "unkown", :event => { :raw_data => raw_data }
    response.status.should == 404
  end

end
