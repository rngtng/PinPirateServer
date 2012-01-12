require 'spec_helper'

describe EventsController do

  context "Event" do
    let(:game) { Game.create }
    let(:data) { ["01", "0A"].join }

    it "creates event" do
      expect do
        post :create, :event => { :data => data }
      end.to change { game.events.count }.by(1)
    end

    it "fails on wrong size event" do
      post :create, :event => { :data => ["02", "0A"].join }
      response.status.should == 400
    end

    context "jsp" do
      it "return ok" do
        post :create, :event => { :data => ["02", "0A"].join }, :format => :jsp
        response.status.should == 200
      end
    end
  end

  context "ScoreEvent" do
    let!(:game) { create(:game, :score => 200, :slot => 1) }
    let(:data) { ["05", "0C", "00", "00", "02", "30"].join }

    it "creates score event" do
      expect do
        post :create, :event => { :data => data }
      end.to change { game.score_events.count }.by(1)
    end

    it "creates score event with lowercase data" do
      expect do
        post :create, :event => { :data => ["05", "0c", "00", "00", "02", "30"].join  }
      end.to change { game.score_events.count }.by(1)
    end

    it "returns json" do
      post :create, :event => { :data => data }
      response.body.should == assigns(:event).to_json(:only => [:id, :game_id], :methods => [:score])
    end

    context "with lower score" do
      let!(:game) { create(:game, :score => 1000, :slot => 1) }

      it "adds score event to current game" do
        expect do
          post :create, :event => { :data => data }
        end.to change { Game.count }.by(1)
      end
    end

    context "with different slot" do
      let!(:game) { create(:game, :score => 200, :slot => 2) }

      it "adds score event to current game" do
        expect do
          post :create, :event => { :data => data }
        end.to change { Game.count }.by(1)
      end
    end
  end

end
