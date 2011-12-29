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
end
