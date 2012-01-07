require 'spec_helper'

describe Event do

  let(:game) { create(:game) }
  let(:event) { game.events.create! :data => data }
  let(:data) { ["0c", "34", "24"].join }

  it "stores data as array" do
    event.reload.data.should == data
  end

end
