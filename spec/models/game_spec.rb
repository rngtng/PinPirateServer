require 'spec_helper'

describe Game do

  it "creates" do
    Game.create.should_not be_new_record
  end

  describe "#latest" do
    let!(:game) { create(:game) }

    it "returns latest" do
      game2 = create(:game, :updated_at => 3.hours.ago)
      Game.latest.first.should == game
    end

    it "returns latest" do
      game2 = create(:game, :updated_at => 3.hours.from_now)
      Game.latest.first.should == game2
    end

    it "returns latest slot aware" do
      game2 = create(:game, :updated_at => 3.hours.ago, :slot => 2)
      Game.latest(2).first.should == game2
    end
  end
end
