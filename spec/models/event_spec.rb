require 'spec_helper'

describe Event do

  let(:game) { create(:game) }
  let(:event) { game.events.create! :raw_data => ["12", "34", "24"] }

  it "stores raw_data as array" do
    event.reload.raw_data.should == ["12", "34", "24"]
  end

end
