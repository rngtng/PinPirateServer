require 'spec_helper'

describe Event do

  let(:event) { Event.create :raw_data => ["12", "34", "24"] }

  it "stores raw_data as array" do
    event.reload.raw_data.should == ["12", "34", "24"]
  end

end
