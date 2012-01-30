require 'spec_helper'

describe Player do

  it "creates model" do
    Player.create(:name => 'Player 1').should_not be_new_record
  end

  context "validation" do
    it "is invalid wihtout name" do
      Player.new.should_not be_valid
    end

    it "is valid with name" do
      Player.new(:name => "Player 1").should be_valid
    end

    it "is invalid with double name" do
      p = Player.create(:name => "Player 1")
      Player.new(:name => p.name).should_not be_valid
    end
  end

  describe "check_twitter_handle" do
    it "adds @ to handle" do
      player = Player.create(:name => 'Player 1', :twitter_handle => "p")
      player.twitter_handle.should == "@p"
    end

    it "is empty if no handle" do
      player = Player.create(:name => 'Player 1')
      player.twitter_handle.should be_nil
    end

    it "keeps handle if @ present" do
      player = Player.create(:name => 'Player 1', :twitter_handle => "@p")
      player.twitter_handle.should == "@p"
    end
  end
end

# == Schema Information
#
# Table name: players
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  twitter_handle :string(255)
#  rfid_id        :string(255)
#

