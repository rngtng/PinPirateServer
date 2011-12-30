require 'spec_helper'

describe Game do

  it "creates" do
    Game.create.should_not be_new_record
  end


end
