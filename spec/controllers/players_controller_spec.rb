require 'spec_helper'

describe PlayersController do

  let!(:game) { create(:game) }
  let!(:player) { game.player }

  it "decreases player game count" do
    expect do
      put :update, :id => player.id, :player => { :name => "New Player" }
    end.to change { player.games.count }.by(-1)
  end

  it "creates new player" do
    expect do
      put :update, :id => player.id, :player => { :name => "New Player" }
    end.to change { Player.count }.by(1)
  end

  it "assigns new player to game" do
    put :update, :id => player.id, :player => { :name => "New Player" }
    game.reload.player_id.should == assigns(:new_player).id
  end

  context "player exits" do
    let!(:player2) { create(:player) }

    it "does not create new player" do
      expect do
        put :update, :id => player.id, :player => { :name => player2.name }
      end.to_not change { Player.count }
    end

    it "assigns new player to game" do
      expect do
        put :update, :id => player.id, :player => { :name => player2.name }
      end.to change { game.reload.player_id }.from(player.id).to(player2.id)
    end
  end


end
