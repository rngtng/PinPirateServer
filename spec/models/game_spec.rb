require 'spec_helper'

describe Game do

  it "creates" do
    Game.create.should_not be_new_record
  end

  describe "#current" do
    let!(:game) { create(:game) }

    it "returns current" do
      game2 = create(:game, :updated_at => 3.hours.ago)
      Game.current.first.should == game
    end

    it "returns current" do
      game2 = create(:game, :updated_at => 3.hours.from_now)
      Game.current.first.should == game2
    end

    it "returns current finished aware" do
      game2 = create(:game, :updated_at => 3.hours.ago)
      game.finish!
      Game.current.first.should == game2
    end

    it "returns current slot aware" do
      game2 = create(:game, :updated_at => 3.hours.ago, :slot => 2)
      Game.current(2).first.should == game2
    end
  end


  describe "#finish" do
    let!(:game) { create(:game) }

    it "doesn't update updated_at" do
      expect do
        game.finish!
      end.to_not change { game.reload.updated_at }
    end

    it "sets finished_at" do
      expect do
        game.finish!
      end.to change { game.reload.finished_at }.from(nil)
    end

    context "with finsihed_at set" do
      let!(:game) { create(:game, :finished_at => 3.hours.ago) }

      it "doesn't updated finished_at" do
        expect do
          game.finish!
        end.to_not change { game.reload.finished_at }
      end
    end

  end

  describe "#high_score?" do
    let!(:game) { create(:game, :score => 100 ) }

    it "is high_score" do
      create(:game, :score => 100000).should be_high_score
    end

    it "is not high_score" do
      create(:game, :score => 50).should_not be_high_score
    end
  end
end
