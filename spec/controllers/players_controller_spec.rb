require 'spec_helper'

describe PlayersController do

  let!(:game) { create(:game) }
  let!(:player) { game.player }

  context "json" do
    it "decreases player game count" do
      expect do
        put :update, :id => player.id, :player => { :name => "New Player" }, :format => :json
      end.to change { player.games.count }.by(-1)
    end

    it "creates new player" do
      expect do
        put :update, :id => player.id, :player => { :name => "New Player" }, :format => :json
      end.to change { Player.count }.by(1)
    end

    it "assigns new player to game" do
      put :update, :id => player.id, :player => { :name => "New Player" }, :format => :json
      game.reload.player_id.should == assigns(:new_player).id
    end

    context "player exits" do
      let!(:player2) { create(:player) }

      it "does not create new player" do
        expect do
          put :update, :id => player.id, :player => { :name => player2.name }, :format => :json
        end.to_not change { Player.count }
      end

      it "assigns new player to game" do
        expect do
          put :update, :id => player.id, :player => { :name => player2.name }, :format => :json
        end.to change { game.reload.player_id }.from(player.id).to(player2.id)
      end
    end
  end

  context "jsp" do
    let!(:player) { create(:player) }
    let(:rfid_id) { "test" }

    before do
      player.update_attributes(:rfid_id => rfid_id)
    end

    it "assigns player to game" do
      put :update, :id => player.rfid_id, :format => :jsp
      game.reload.player_id.should == player.id
    end

    it "doesn' fail for unknown rfid" do
      put :update, :id => "unknown", :format => :jsp
      response.status.should == 200
    end


  end

end
