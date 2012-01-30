require 'spec_helper'

describe ScoreEvent do

  let(:game) { create(:game) }
  let(:player) { game.player }
  let(:score_event) { game.score_events.create :data => ["0c", "34", "24"].join }

  it "creates slot" do
    score_event.slot.should == 1
  end

  it "creates score" do
    score_event.score.should == 3424
  end

  it "creates game" do
    score_event.game.should == game
  end

  it "fails on wrong slot" do
    expect do
      game.score_events.create! :data => ["07", "34", "24"].join
    end.to raise_error
  end

  it "updates game" do
    expect do
      score_event
    end.to change { game.reload.score }.to(3424)
  end

  describe "#game_id" do
    context "wrong slot" do
      let(:score_event) { game.score_events.create :data => ["0b", "34", "24"].join }

      it "created new game" do
        score_event.game_id.should_not == game.id
      end

      it "has new slot" do
        score_event.game.slot == 2
      end

      it "sets new game score" do
        score_event.game.score == 3424
      end

      it "updates not old game highscore" do
        expect do
          score_event
        end.to_not change { game.score }
      end
    end

    context "existing higher game" do
      let(:score) { 5000 }

      before do
        game.update_attributes(:score => score)
      end

      it "created new game" do
        score_event.game_id.should_not == game.id
      end

      it "retains slot" do
        score_event.game.slot == game.slot
      end

      it "sets new game" do
        score_event.game.score == 3424
      end

      it "updates not old game highscore" do
        expect do
          score_event
        end.to_not change { game.score }
      end

      it "finishes old game highscore" do
        expect do
          score_event
        end.to change { game.reload.finished_at }.from(nil)
      end
    end
  end

   describe "check_game_score" do
     let(:score) { 5000 }

     before do
       game.update_attributes(:score => score)
     end

     it "finishes all games asap one is done" do
        game2 = create(:game, :slot => 2)

        expect do
          score_event
        end.to change { game2.reload.finished_at }.from(nil)
     end

     #Double tested
     it "doesn't update updated_at" do
       expect do
         score_event
       end.to_not change { game.reload.updated_at }
     end
   end
end

# == Schema Information
#
# Table name: events
#
#  id         :integer(4)      not null, primary key
#  game_id    :integer(4)
#  type       :string(255)
#  data       :string(255)     default(""), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_events_on_game_id  (game_id)
#

