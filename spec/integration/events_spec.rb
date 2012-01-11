require 'spec_helper'

class Array
  def to_hex
    self.map { |d| "%02x" % d.to_i(16) }.join
  end
end

describe "events", :type => :request do

  it "comsumes 10 events" do
    @from = File.open( Rails.root.join("spec", "fixtures", "game.log").to_s, "r")

    expect do
      expect do
        expect do
          expect do

            10.times do
              data = @from.readline.strip.split(",").to_hex
              post events_path, :event => { :data => data }
            end

          end.to change { ScoreEvent.count }.from(0).to(2)
        end.to change { Event.count }.from(0).to(8) #first two are invalid
      end.to change { Player.count }.from(0).to(1)
    end.to change { Game.count }.from(0).to(1)

    Game.latest.first.tap do |game|
      game.score.should == 41530
      game.slot.should == 3
    end

    Player.first.tap do |player|
      player.name.should == "Player 3"
    end
  end

  it "comsumes 1000 events" do
    @from = File.open( Rails.root.join("spec", "fixtures", "game.log").to_s, "r")

    expect do
      expect do
        expect do
          expect do

            1000.times do
              data = @from.readline.strip.split(",").to_hex
              post events_path, :event => { :data => data }
            end

          end.to change { ScoreEvent.count }.from(0).to(349)
        end.to change { Event.count }.from(0).to(998) #first two are invalid
      end.to change { Player.count }.from(0).to(3)
    end.to change { Game.count }.from(0).to(6)

    Game.latest.first.tap do |game|
      game.score.should == 1803530
      game.slot.should == 1
      game.player.name.should == "Player 1"
    end

    Game.finished.order("score DESC").first.tap do |game|
      game.score.should == 14377160
      game.slot.should == 3
      game.player.name.should == "Player 3"
    end

    Player.first.tap do |player|
      player.name.should == "Player 3"
    end

    Player.last.tap do |player|
      player.name.should == "Player 2"
    end
  end

end
