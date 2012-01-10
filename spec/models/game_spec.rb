require 'spec_helper'

describe Game do

  it "creates" do
    Game.create.should_not be_new_record
  end

  describe "#latest" do
    let!(:older_game) { create(:game, :updated_at => 3.hours.ago) }
    let!(:game) { create(:game) }

    it "returns latest" do
      Game.latest.first.should == game
    end

    it "returns newer_game" do
      older_game.update_attribute(:updated_at, 3.hours.from_now)
      Game.latest.first.should == older_game
    end

    it "returns latest finished aware" do
      game.finish!
      Game.not_finished.latest.first.should == older_game
    end

    it "returns latest slot aware" do
      older_game.update_attribute( :slot, 2)
      Game.with_slot(2).latest.first.should == older_game
    end
  end


  describe "#finish" do
    let!(:game) { create(:game) }

    it "doesn't update updated_at" do
      expect do
        expect do
          game.finish!
        end.to change { game.reload.finished_at }.from(nil)
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

  describe "#get_slot" do
    {
      "C"  => 1,
      "c"  => 1,
      "0c" => 1,
      "0D" => 2,
      "0F" => 4,
    }.each do |input, should|
      it "is #{should} for #{input}" do
        Game.get_slot(input).should == should
      end
    end
  end
end
