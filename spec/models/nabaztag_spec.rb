require 'spec_helper'

describe Nabaztag do
  CMD  = 30
  CMD1 = 31
  let(:data) { [1,2,3,4,5] }
  let(:size) { Nabaztag::Message.to_3b(data.size) }

  before do
    Nabaztag::Message.stub!(:full_message).and_return do |data|
      data
    end
  end

  describe ".build" do
    it "accepts single input" do
      Nabaztag::Message.build(CMD).should == [[CMD, 0, 0, 0]]
    end

    it "accepts flat input" do
      Nabaztag::Message.build(CMD, *data).should == [[CMD, *size, *data]]
    end

    it "accepts array input" do
      Nabaztag::Message.build([CMD, *data]).should == [[CMD, *size, *data]]
    end

    it "accepts multiple array input" do
      Nabaztag::Message.build([CMD, *data], [CMD1, *data]).should == [[CMD, *size, *data], [CMD1, *size, *data]]
    end

    it "accepts hash input" do
      Nabaztag::Message.build(CMD => data, CMD1 => data).should == [[CMD, *size, *data], [CMD1, *size, *data]]
    end
  end

  describe ".to_3b" do
    it "accepts zero" do
      Nabaztag::Message.to_3b(0).should == [0, 0, 0]
    end

    it "accepts 2 byte input" do
      Nabaztag::Message.to_3b(511).should == [0, 1, 255]
    end

    it "accepts 3 byte input" do
      Nabaztag::Message.to_3b(6334239).should == [96, 167, 31]
    end
  end
end