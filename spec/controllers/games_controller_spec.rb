require 'spec_helper'

describe GamesController do

  let(:player) { Player.create( :name => "Player 1" ) }
  let!(:game) { player.games.create }

  it "returns valid page" do
    get :index
    response.status.should == 200
  end

  it "assigns not_finished games" do
    get :index
    assigns(:games).should_not be_nil
  end

  context "filter" do
    let!(:game2) { create(:game, :score => 400000, :finished_at => 3.minutes.from_now) }
    let!(:game3) { create(:game, :score =>   4000, :finished_at => 3.minutes.from_now) }
    let!(:game4) { create(:game, :score =>  40000, :finished_at => 1.day.ago, :player => game3.player) } #past

    it "assigns daily games" do
      get :index, :filter => 'daily'
      assigns(:games).should == [game2, game3]
    end

    it "assigns alltime games" do
      get :index, :filter => 'alltime'
      assigns(:games).should == [game2, game4, game3]
    end

    it "assigns player games" do
      get :index, :filter => 'player'
      assigns(:games).should == [game2, game4]
    end
  end
end
